class TeamMember
  def initialize(team)
    @team = team
  end

  def all
    User.joins('LEFT OUTER JOIN invites ON users.id = invites.user_id').
      where('users.team_id = ? OR users.id = invites.user_id', @team.id).
      order(:username)
  end
end
