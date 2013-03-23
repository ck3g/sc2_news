class ProfilesController < ApplicationController
  respond_to :html

  authorize_resource except: [:show]

  before_filter :find_profile

  def show
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

  private
  def find_profile
    @profile = Profile.find params[:id]
  end
end
