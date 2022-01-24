class ApplicationController < ActionController::Base
  impersonates :user
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_root

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to redirect_to root_path, notice: exception.message }
    end
  end

  def configure_permitted_parameters
    extra_keys = [:avatar, :name]
    devise_parameter_sanitizer.permit(:sign_up, keys: extra_keys)
    devise_parameter_sanitizer.permit(:account_update, keys: extra_keys)
  end

  def redirect_to_root
    redirect_to root_path
  end

end
