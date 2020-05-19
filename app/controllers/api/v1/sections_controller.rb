class Api::V1::SectionsController < Api::V1::ApplicationController
  before_action :set_guide, only: [:show]
	
	def show
		@sections = @guide.sections.order(order: :asc).map do |section|
		  { :id => section.id, 
		  	:name => section.name
		  }
		end
		render json: { sections: @sections }.to_json
	end

	private

		def set_guide
			@guide = Guide.find(params[:id])
		end

end