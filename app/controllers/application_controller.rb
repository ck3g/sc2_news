class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :json

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :status => :not_found, :layout => false }
      format.any  { head :not_found }
    end
  end
end
