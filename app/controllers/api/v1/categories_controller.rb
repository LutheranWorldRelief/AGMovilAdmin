class Api::V1::CategoriesController < Api::V1::ApplicationController

	def index		
		@categories = Category.all.order("id ASC").map do |category|
		  { :id => category.id, 
		  	:name => category.name,
		  	:image => "http://agd.codecastle.com.sv#{category.image.url}",
		  	:description => category.description
		  }
		end
		render json: { categories: @categories }.to_json
	end

end
