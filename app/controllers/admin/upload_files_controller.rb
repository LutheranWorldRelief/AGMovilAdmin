class Admin::UploadFilesController < Admin::ApplicationController
	before_action :set_file, only: [:destroy, :update, :edit]
	def index
		@active_item_5 = true
		@files = UploadFile.all
	end

	def new
		@file = UploadFile.new
		@types = [['MP3', 'mp3'], ['MP4', 'mp4'], ['PDF','pdf'], ['AVI','avi'], ['WAV','wav'], ['WMV','wmv'], ['DOCX','docx'], ['JPG', 'jpg'], ['JPEG', 'jpeg'], ['PNG', 'png']]
		@guides = Guide.all
	end

	def create
		@file = UploadFile.new(file_params)
		if @file.save
			redirect_to admin_upload_files_path, notice: "Guardado..."
		else
			redirect_to admin_upload_files_path, alert: "Ocurrio un error..."
		end
	end

	def edit
		@guides = Guide.all
	end

	def update
		if @file.update(file_params)
			redirect_to admin_upload_files_path, notice: "Actulizado..."
		else
			redirect_to admin_upload_files_path, alert: "Ocurrio un error..."
		end
	end

	def destroy
		@file.remove_file_upload!
		if @file.destroy
			redirect_to admin_upload_files_path, notice: "Eliminado..."
		else
			redirect_to admin_upload_files_path, alert: "Ocurrio un error..."
		end
	end

	private

		def set_file
			@file = UploadFile.find(params[:id])
		end

		def file_params
			params.require(:upload_file).permit(:file_upload, :order, :guide_id, :name, :description, :file_type)
		end
end