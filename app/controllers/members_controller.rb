class MembersController < ApplicationController

  before_filter :find_team, only: [:index]

  def index
    @invite = Invite.new
    @members = TeamMember.new(@team).all
  end

  private
  def find_team
    @team = Team.find params[:team_id]
  end
end
