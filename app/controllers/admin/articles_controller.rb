class Admin::ArticlesController < Admin::ApplicationController
	before_action :set_article, only: [ :show, :edit, :update, :destroy ]
	skip_before_action :authenticate_user!, only: [ :show ]
	
	def index
		@active_item_4 = true
		@articles = Article.all.order(section_id: :asc).paginate(:page => params[:page], :per_page => 10)
		if params[:filter]
			if params[:filter][:guide].present?
				@articles = @articles.where(section_id: params[:section][:id].to_i)
			end
		end
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		if @article.save
			redirect_to admin_articles_path, notice: "Guardado..."
		else
			redirect_to admin_articles_path, alert: "Ocurrio un error..."
		end
	end

	def edit
	end

	def update
		if @article.update(article_params)
			redirect_to admin_articles_path, notice: "Actualizado..."
		else
			redirect_to admin_articles_path, alert: "Ocurrio un error..."
		end
	end

	def destroy
		if @article.destroy
			redirect_to admin_articles_path, notice: "Eliminado..."
		else
			redirect_to admin_articles_path, alert: "Ocurrio un error..."
		end
	end

	def show
		render layout: "application"
	end

	def get_sections
		sections = []
	    find_sections = Section.where(guide_id: params[:guide_id])
	    find_sections.each do |sc|
	      sections << {"id": sc.id, "name": sc.name}
	    end    
    render json: sections
	end

	private

		def set_article
			@article = Article.friendly.find(params[:id])
		end

		def article_params
			params.require(:article).permit(:name, :order, :section_id, :title, :description, :content, :section)
		end
end
