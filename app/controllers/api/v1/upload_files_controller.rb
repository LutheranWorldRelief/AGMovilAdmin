class Api::V1::UploadFilesController < Api::V1::ApplicationController
	before_action :set_guide, only: [:show]

	def show
		@files = @guide.upload_files.map do |file|
			{
				:id => file.id,
				:url => "http://DOMAIN#{file.file_upload.url}",
				:description => file.description,
				:file_name => file.name,
				:file_type => file.file_type,
				:order => file.order
			}
		end
		render json: { files: @files }
	end

	private

		def set_guide
			@guide = Guide.find(params[:id])
		end
end
