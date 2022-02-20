# == Schema Information
#
# Table name: articles
#
#  id              :bigint           not null, primary key
#  name            :string
#  title           :string
#  description     :text
#  content         :text
#  order           :integer          default(0)
#  section_id      :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  slug            :string
#  content_base_64 :text
#

class Article < ApplicationRecord
	extend FriendlyId
  friendly_id :slug_articles, use: :slugged

  belongs_to :section
  before_save :change_content_urls_for_imgs, :fill_content_base_64
  
  validates :name, :title, :section_id, :order, presence: true

  def slug_articles
	  [
	    :name,
	    [:name, :id]
	  ]
  end

  private

    # this method will be execute before saving
    def change_content_urls_for_imgs

      self.content = content.to_s.gsub("src=\"/uploads/ckeditor/pictures/","src=\"https://admin.cacaomovil.com/uploads/ckeditor/pictures/")
    end

    # this method will be execute before saving and after change_content_urls_for_imgs
    # to get full url from image src attribute
    def fill_content_base_64

      # duplicating content attribute content to modify its data and save it later in content_base_64 field
      content_tmp = content.dup.to_s

      # using extensión to search inside html code
      html = Nokogiri::HTML.fragment(content_tmp)

      # getting image collection from the nokogiri object
      imgs = html.css('img').collect()

      imgs.each do |img|

        src = img.attr('src').to_s.strip
        img_file = URI.open(src)
        img_mimetype = MimeMagic.by_magic(img_file).type # => "image/jpeg"
        img_base_64 = Base64.encode64(img_file.read)

        puts "#{src} | #{img_mimetype}"

        # generating the base64 string used that will be used in src attribute
        src_img_base_64 = "data:#{img_mimetype};base64,#{img_base_64}"

        # replacing src url with base64 string
        content_tmp[src] = src_img_base_64

      end

      self.content_base_64 = content_tmp
    end

end
