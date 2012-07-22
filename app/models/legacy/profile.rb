class Legacy::Profile < Legacy::Base
  self.table_name = "UsersProfiles"

  def import(profile)
    profile.country_id       = self.country_id
    profile.race             = self.race
    profile.bnet_name        = self.bnet_name
    profile.bnet_server      = self.bnet_server
    profile.league           = self.league
    profile.experience       = self.experience
    profile.first_name       = self.first_name
    profile.last_name        = self.last_name
    profile.details          = self.details
    profile.avatar_style     = self.avatar_style
    profile.achievements     = self.achievements
    profile.rank             = self.rank
    profile.points           = self.points
    profile.wins             = self.wins
    profile.loses            = self.loses
    profile.win_rate         = self.win_rate
    profile.profile_url      = self.profile_url
    profile.synchronized_at  = self.synchronized_at

    profile.save
  end
end
