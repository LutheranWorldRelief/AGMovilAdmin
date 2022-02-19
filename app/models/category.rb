# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  image       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  cat_order   :integer
#

class Category < ApplicationRecord
	has_many :guides, dependent: :destroy
	mount_uploader :image, CategoryUploader
end
