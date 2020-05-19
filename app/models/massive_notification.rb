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
