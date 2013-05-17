class TeamsController < ApplicationController
  authorize_resource

  def show
    @team = Team.find params[:id]
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.teams.new params[:team]
    flash.notice = t(:created_successfully) if @team.save
    respond_with @team
  end
end
