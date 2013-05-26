class MembersController < ApplicationController

  before_filter :find_team, only: [:index]
  before_filter :check_manage_members_ability

  def index
    @invite = Invite.new
    @members = TeamMember.new(@team).all
  end

  private
  def find_team
    @team = Team.find params[:team_id]
  end

  def check_manage_members_ability
    if cannot? :manage, @team
      raise CanCan::AccessDenied.new(
        t('unauthorized.manage.all'), :show, @team)
    end
  end
end
