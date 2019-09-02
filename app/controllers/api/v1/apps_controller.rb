class Api::V1::AppsController < Api::V1::ApplicationController

	def index

		@apps = CategoryApp.all.map do |category_app|
		  { :id => category_app.id,
		  	:name => category_app.name,
		  	:name => "http://DOMAIN#{category_app.icon.url}",
		  	:description => category_app.description,
		  	:apps => category_app.apps.order(name: :asc).map do |app|
		  		{
			  		:id => app.id,
			  		:name => app.name,
				  	:image => "http://DOMAIN#{app.image.url}",
				  	:app_type => app.app_type,
				  	:outstanding => app.outstanding,
				  	:app_url => app.app_url
		  		}
		  	end
		  }
		end
		render json: { categories: @apps }.to_json
	end

end
