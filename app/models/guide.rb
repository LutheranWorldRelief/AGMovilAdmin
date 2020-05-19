# == Schema Information
#
# Table name: guides
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  order       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  category_id :bigint(8)
#  image       :string
#

class Guide < ApplicationRecord
	extend FriendlyId
  friendly_id :slug_guides, use: :slugged
  mount_uploader :image, GuideUploader

#<<<<<<< HEAD
	#has_many :sections
  # has_many :upload_files
# =======
	has_many :sections, dependent: :destroy
  has_many :upload_files, dependent: :destroy
#>>>>>>> c1f35f30661f12ff39c06591dc6b04146f37c392
	belongs_to :category

	validates :name, :order, :category_id, presence: true

	  def slug_guides
	  [
	    :name,
	    [:name, :id]
	  ]
  end
end
