class Admin::CategoryAppsController < Admin::ApplicationController
	before_action :set_category_app, only: [ :edit, :update, :destroy ]
	def index
		@active_item_8 = true
		@category_apps = CategoryApp.all.paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@category_app = CategoryApp.new
	end

	def create
		@category_app = CategoryApp.new(app_params)
		if @category_app.save
			redirect_to admin_category_apps_path, notice: "Guardado..."
		else
			redirect_to admin_category_apps_path, alert: "Ocurrio un error..."
		end
	end

	def edit
	end

	def update
		if @category_app.update(app_params)
			redirect_to admin_category_apps_path, notice: "Actualizado..."
		else
			redirect_to admin_category_apps_path, alert: "Ocurrio un error..."
		end
	end

	def destroy
		if @category_app.destroy
			redirect_to admin_category_apps_path, notice: "Eliminado..."
		else
			redirect_to admin_category_apps_path, alert: "Ocurrio un error..."
		end
	end

	private

		def set_category_app
			@category_app = CategoryApp.find(params[:id])
		end

		def app_params
			params.require(:category_app).permit(:name, :description, :icon)
		end
end