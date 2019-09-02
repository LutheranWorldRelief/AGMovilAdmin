class Admin::HomeController < Admin::ApplicationController
	before_action :set_user, only: [ :edit, :update]

	def index
		@users = User.all
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to admin_home_index_path, notice: "Actualizado..."
		else
			redirect_to admin_home_index_path, alert: "Ocurrio un error..."
		end
	end

	private

		def set_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:password, :password_confirmation)
		end
end