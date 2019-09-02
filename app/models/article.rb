# == Schema Information
#
# Table name: articles
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  title       :string
#  description :text
#  content     :text
#  order       :integer          default(0)
#  section_id  :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

class Article < ApplicationRecord
	extend FriendlyId
  friendly_id :slug_articles, use: :slugged

  belongs_to :section
  
  validates :name, :title, :section_id, :order, presence: true

  def slug_articles
	  [
	    :name,
	    [:name, :id]
	  ]
  end

end
