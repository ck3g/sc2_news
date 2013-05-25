class TeamsController < ApplicationController
  authorize_resource

  before_filter :check_team_presence, only: [:new]
  before_filter :find_team, only: [:show, :edit, :update, :destroy]
  before_filter :check_access, only: [:edit, :update, :destroy]

  def index
    @teams = Team.order(:name)
  end

  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.teams.new params[:team]
    flash.notice = t(:created_successfully) if @team.save
    respond_with @team
  end

  def edit
  end

  def update
    if @team.update_attributes params[:team]
      flash.notice = t(:updated_successfully)
    end
    respond_with @team
  end

  def destroy
    @team.destroy
    redirect_to root_url, notice: t('teams.has_been_disbanded')
  end

  private
  def check_team_presence
    if current_user.in_team?
      flash.alert = t('teams.cannot_create_while_in_team')
      redirect_to current_user.current_team
    end
  end

  def find_team
    @team = Team.find params[:id]
  end

  def check_access
    if cannot? :edit, @team
      raise CanCan::AccessDenied.new t('unauthorized.edit.team')
    end
  end
end
