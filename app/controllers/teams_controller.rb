class TeamsController < ApplicationController
  authorize_resource

  before_filter :check_team_presence, only: [:new]

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

  private
  def check_team_presence
    if current_user.in_team?
      flash.alert = t('teams.cannot_create_while_in_team')
      redirect_to current_user.current_team
    end
  end
end
