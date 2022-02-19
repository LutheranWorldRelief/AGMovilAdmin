# == Schema Information
#
# Table name: upload_files
#
#  id          :bigint           not null, primary key
#  file_upload :string
#  order       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  name        :string
#  file_type   :integer
#  guide_id    :bigint
#

class UploadFile < ApplicationRecord
  belongs_to :guide, optional: true
  mount_uploader :file_upload, FileUploader

  enum file_type: [ :mp3, :mp4, :pdf, :avi, :wav, :wmv, :docx, :jpg, :jpeg, :png ]

  validates :file_upload, :name, :order, :file_type, presence: true

  def get_icon_uf
  	icon = ""
		case self.file_type
		when "mp4"    
		  icon = "video"
		when "mp3"
		  icon = "music"
		when "mav"
		  icon = "music"
		when "pdf"
		  icon = "file-pdf"
		when "avi"    
		  icon = "video"
		when "wmv"    
		  icon = "video"
		when "docx"    
		  icon = "file-word"
		when "jpg"    
		  icon = "image"
		when "jpeg"    
		  icon = "image"
		when "png"    
		  icon = "image"
		else
		  icon = "link"
		end
		return icon
  end

end
