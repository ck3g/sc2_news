class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :json

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :status => :not_found, :layout => false }
      format.any  { head :not_found }
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |user|
      user.permit(:username, :email, :password, :password_confirmation)
    end
  end
end
