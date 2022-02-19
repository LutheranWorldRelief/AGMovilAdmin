# == Schema Information
#
# Table name: category_apps
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  icon        :string
#

class CategoryApp < ApplicationRecord
	mount_uploader :icon, CategoryAppUploader
	has_many :apps

  validates :name, presence: true
end
