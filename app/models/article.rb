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
  
  validates :name, :title, :section_id, :order, presence: true

  def slug_articles
	  [
	    :name,
	    [:name, :id]
	  ]
  end

end
