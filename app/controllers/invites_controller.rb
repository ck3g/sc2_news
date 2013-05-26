class InvitesController < ApplicationController
  authorize_resource

  before_filter :find_invite, only: [:accept, :reject]

  def index
    @invites = Invite.where(user_id: current_user.id).order('created_at DESC')
  end

  def create
    @invite = Invite.build_from_params(current_user, params[:invite])
    if @invite.save
      redirect_to team_members_path(current_user.current_team),
        notice: t('teams.member_has_been_invited')
    else
      @team = current_user.current_team
      @members = TeamMember.new(@team).all
      render 'members/index'
    end
  end

  def accept
    @invite.accept
    redirect_to invites_url
  end

  def reject
    @invite.reject
    redirect_to invites_url
  end

  private
  def find_invite
    @invite = current_user.invites.find params[:id]
  end
end
