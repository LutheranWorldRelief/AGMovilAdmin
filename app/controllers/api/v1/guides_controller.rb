class Api::V1::GuidesController < Api::V1::ApplicationController
	before_action :set_category, only: [:show]
	before_action :set_guide, only: [:guide]
	
	def show
		@guides = @category.guides.order(order: :asc).map do |guide|
		  { :id => guide.id, 
		  	:name => guide.name,
		  	:image => "https://admin.cacaomovil.com#{guide.image.url}",
				:order => guide.order,
				:archive => guide.upload_files.length == 0 ? false : true
		  }
		end
		render json: { guides: @guides }.to_json
	end

	def guide
		@guides = 
		  { 
		  	:id => @guide.id, 
		  	:name => @guide.name,
				:order => @guide.order,
				:archive => @guide.upload_files.length == 0 ? false : true,
		  	:image => "https://admin.cacaomovil.com#{@guide.image.url}",
		  	:sections => @guide.sections.order(order: :asc).map do |section|
		  		{
		  			:id => section.id,
		  			:name => section.name,
		  			:order => section.order,
		  			:articles => section.articles.order(order: :asc).map do |article|
		  				{
		  					:id => article.id,
		  					:name => article.name,
		  					:title => article.title,
								:description => article.description,
								:content => article.content_base_64,
								:order => article.order
		  				}
		  			end
		  		}
		  	end
		  }
		render json: { guide: @guides }.to_json
	end

	private

		def set_category
			@category = Category.find(params[:id])
		end

		def set_guide
			@guide = Guide.find(params[:id])
		end

end
