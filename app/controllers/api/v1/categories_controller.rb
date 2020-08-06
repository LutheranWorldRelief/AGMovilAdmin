class Api::V1::CategoriesController < Api::V1::ApplicationController

	def index		
		@categories = Category.all.order("order ASC").map do |category|
		  { :id => category.id, 
		  	:name => category.name,
		  	:image => "https://admin.cacaomovil.com#{category.image.url}",
		  	:description => category.description
		  }
		end
		render json: { categories: @categories }.to_json
	end

end
