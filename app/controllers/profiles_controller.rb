class ProfilesController < ApplicationController
  respond_to :html

  authorize_resource except: [:show]

  before_filter :find_profile

  def show
    respond_with @profile
  end

  def edit
    respond_with @profile
  end

  def update
    if @profile.update_attributes params[:profile]
      flash[:notice] = t(:updated_successfully)
    end
    respond_with @profile
  end

  def sync
    @profile.sync!
    redirect_to @profile
  end

  private
  def find_profile
    if params[:username].present?
      profile_id = User.where(username: params[:username]).first.try(:profile).try(:id)
      @profile = Profile.find profile_id
    else
      @profile = Profile.find params[:id]
    end
  end
end
