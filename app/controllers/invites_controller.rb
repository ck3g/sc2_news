class InvitesController < ApplicationController
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
end
