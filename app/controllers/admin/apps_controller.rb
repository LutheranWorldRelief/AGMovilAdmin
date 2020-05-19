class Admin::AppsController < Admin::ApplicationController
	before_action :set_app, only: [ :edit, :update, :destroy ]
	def index
		@active_item_6 = true
		@apps = App.all.paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@app = App.new
	end

	def create
		@app = App.new(app_params)
		if @app.save
			redirect_to admin_apps_path, notice: "Guardado..."
		else
			redirect_to admin_apps_path, alert: "Ocurrio un error..."
		end
	end

	def edit
	end

	def update
		if @app.update(app_params)
			redirect_to admin_apps_path, notice: "Actualizado..."
		else
			redirect_to admin_apps_path, alert: "Ocurrio un error..."
		end
	end

	def destroy
		if @app.destroy
			redirect_to admin_apps_path, notice: "Eliminado..."
		else
			redirect_to admin_apps_path, alert: "Ocurrio un error..."
		end
	end

	private

		def set_app
			@app = App.find(params[:id])
		end

		def app_params
			params.require(:app).permit(:name, :image, :app_type, :app_url, :category_app_id, :outstanding)
		end
end