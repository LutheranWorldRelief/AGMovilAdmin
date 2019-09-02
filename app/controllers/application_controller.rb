class ApplicationController < ActionController::Base
	layout :layout_by_resource
	before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:names, :lastnames])
  end

  def after_sign_in_path_for(resource)
    admin_home_index_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  private

  def layout_by_resource
    if devise_controller?
      "admin_login"
    else
      "application"
    end
  end
end
