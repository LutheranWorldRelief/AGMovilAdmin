# == Schema Information
#
# Table name: sections
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  order      :integer          default(0)
#  guide_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Section < ApplicationRecord
	extend FriendlyId
  friendly_id :slug_sections, use: :slugged

  belongs_to :guide
  has_many :articles, dependent: :destroy

  validates :name, :order, :guide_id, presence: true

  def slug_sections
	  [
	    :name,
	    [:name, :id]
	  ]
  end
end
