# == Schema Information
#
# Table name: apps
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  image           :string
#  app_type        :integer
#  app_url         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_app_id :bigint(8)
#

class App < ApplicationRecord
	mount_uploader :image, AppUploader

	belongs_to :category_app

	validates :name, :app_type, :app_url, :category_app_id, presence: true

	enum app_type: [ :web, :app ]
end
