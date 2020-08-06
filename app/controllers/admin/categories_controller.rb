class Admin::CategoriesController < Admin::ApplicationController
	before_action :set_category, only: [ :show, :edit, :update, :destroy ]
	def index
		@active_item_7 = true
		@categories = Category.all.paginate(:page => params[:page], :per_page => 10).order("cat_order ASC")
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			redirect_to admin_categories_path, notice: "Guardado..."
		else
			redirect_to admin_categories_path, alert: "Ocurrio un error..."
		end
	end

	def edit
	end

	def update
		if @category.update(category_params)
			redirect_to admin_categories_path, notice: "Actualizado..."
		else
			redirect_to admin_categories_path, alert: "Ocurrio un error..."
		end
	end

	def destroy
		if @category.destroy
			redirect_to admin_categories_path, notice: "Eliminado..."
		else
			redirect_to admin_categories_path, alert: "Ocurrio un error..."
		end
	end

	def show
		
	end

	private

		def set_category
			@category = Category.find(params[:id])
		end

		def category_params
			params.require(:category).permit(:name, :image, :description, :cat_order)
		end
end