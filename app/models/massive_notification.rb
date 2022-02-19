# == Schema Information
#
# Table name: massive_notifications
#
#  id          :bigint           not null, primary key
#  title       :string
#  message     :text
#  big_picture :string
#  players     :text             default([]), is an Array
#  status      :integer          default("draft")
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MassiveNotification < ApplicationRecord
	mount_uploader :big_picture, MassiveNotificationUploader
  #belongs_to :user

  enum status: [:draft, :sended, :trashed]

  validates :title, :message, presence: true

	def status_s
  	case self.status
  	when "draft"
  		return "Borrador"
  	when "sended"
  		return "Enviado"
  	else
			return "Papelera"
		end
  end

  def validates_form
    #title.present? && message.present? && players.present?
    title.present? && message.present?
  end
end
