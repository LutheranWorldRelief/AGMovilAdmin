class Api::V1::AppsController < Api::V1::ApplicationController

	def index
		@apps = CategoryApp.all.map do |category_app|
		  { :id => category_app.id,
		  	:name => category_app.name,
		  	:icon => "http://agd.codecastle.com.sv#{category_app.icon.url}",
		  	:description => category_app.description,
		  	:apps => category_app.apps.order(name: :asc).map do |app| 
		  		{
			  		:id => app.id,
			  		:name => app.name,
				  	:image => "http://agd.codecastle.com.sv#{app.image.url}",
				  	:app_type => app.app_type,
				  	:outstanding => app.outstanding,
				  	:app_url => app.app_url
		  		}
		  	end
		  }
		end
		render json: { categories: @apps }.to_json
	end
    	def cocoa_price
        	@price = ""
    		@pc = ""
    		@pcp = ""

    		doc = Nokogiri::HTML(open('https://es.investing.com/commodities/us-cocoa'))
    		doc.search('.pid-8894-last').each do |price|
      			@price = price.content
    		end
    		doc.search('.pid-8894-pc').each do |pc|
      			@pc = pc.content
    		end
    		doc.search('.pid-8894-pcp').each do |pcp|
      			@pcp = pcp.content
    		end
    		render json: {cocoa_price: @price, pc: @pc, pcp: @pcp}
   	 end
end
