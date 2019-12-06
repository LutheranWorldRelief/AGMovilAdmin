class Admin::ArticlesController < Admin::ApplicationController
	before_action :set_article, only: [ :show, :edit, :update, :destroy ]
	def index
		@active_item_4 = true
		@articles = Article.all.order(section_id: :asc).paginate(:page => params[:page], :per_page => 10)
		if params[:filter]
			if params[:filter][:guide].present?
				@articles = @articles.where(section_id: Section.where(guide_id: params[:filter][:guide].to_i))
			end
		end
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		if @article.save
			@article.content = @article.content.gsub("/uploads/ckeditor/pictures/","http://DOMAIN/uploads/ckeditor/pictures/")
			@article.save
			redirect_to admin_articles_path, notice: "Guardado..."
		else
			redirect_to admin_articles_path, alert: "Ocurrio un error..."
		end
	end

	def edit
	end

	def update
		if @article.update(article_params)
			@article.content = @article.content.gsub("/uploads/ckeditor/pictures/","http://DOMAIN/uploads/ckeditor/pictures/")
			@article.save
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

	private

		def set_article
			@article = Article.friendly.find(params[:id])
		end

		def article_params
			params.require(:article).permit(:name, :order, :section_id, :title, :description, :content)
		end
end