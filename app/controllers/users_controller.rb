class UsersController < ApplicationController
  authorize_resource

  before_filter :find_user, only: [:edit, :update]

  respond_to :html

  def index
    @users = apply_scopes(User).order(:username).page(params[:page])
  end

  def edit
    respond_with @user
  end

  def update
    if @user.update_attributes! params[:user]
      flash[:notice] = I18n.t(:updated_successfully)
    end
    respond_with @user, location: users_path
  end

  private
  def find_user
    @user = User.find params[:id]
  end
end
