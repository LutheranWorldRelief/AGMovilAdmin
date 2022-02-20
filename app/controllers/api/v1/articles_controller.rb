class Api::V1::ArticlesController < Api::V1::ApplicationController
  before_action :set_section, only: [:show]
	
	def show
		@articles = @section.articles.order(order: :asc).map do |article|
		  { 
		  	:id => article.id, 
		  	:name => article.name, 
		  	:title => article.title, 
		  	:description => article.description, 
				:link => "https://admin.cacaomovil.com/admin/articles/#{article.slug}",
		  	:content => article.content_base_64
		  }
		end
		render json: { articles: @articles }.to_json
	end

	private
		def set_section
			@section = Section.find(params[:id])
		end
end
#
#  id          :bigint(8)        not null, primary key
#  file_upload :string
#  order       :integer          default(0)
#  article_id  :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  name        :string
#  file_type   :integer

