# == Schema Information
#
# Table name: sections
#
#  id         :bigint           not null, primary key
#  name       :string
#  order      :integer          default(0)
#  guide_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Section < ApplicationRecord
	extend FriendlyId
  friendly_id :slug_sections, use: :slugged

  belongs_to :guide
#<<<<<<< HEAD
#  has_many :articles
#=======
  has_many :articles, dependent: :destroy
#>>>>>>> c1f35f30661f12ff39c06591dc6b04146f37c392

  validates :name, :order, :guide_id, presence: true

  def slug_sections
	  [
	    :name,
	    [:name, :id]
	  ]
  end
end
