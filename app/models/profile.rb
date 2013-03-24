class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :country

  attr_accessible :country_id, :race, :bnet_name, :bnet_server, :league, :experience, :first_name,
    :last_name, :details, :avatar_style, :achievements, :rank, :points, :wins, :loses, :win_rate,
    :profile_url, :synchronized_at

  validate :profile_url_cannot_be_invalid_battlenet_url

  delegate :email, :current_sign_in_at, to: :user, prefix: true
  delegate :username, to: :user, prefix: false
  delegate :name, to: :country, prefix: true, allow_nil: true

  def fullname
    "#{first_name} #{last_name}"
  end

  def has_played_games?
    wins > 0
  end

  def has_league?
    league.present? && league != "_"
  end

  def league_parts
    league.split "_"
  end

  def sync!
    player = BattleNetInfo.new profile_url
    data = player.to_hash
    self.bnet_server = data[:server]
    self.bnet_name = data[:player_name]
    self.achievements = data[:achievement_points]
    self.points = data[:points]
    self.wins = data[:wins]
    self.rank = data[:rank]
    self.league = data[:league]
    self.avatar_style = player.portrait_html_style("/assets/bnet/")
    self.synchronized_at = Time.current
    self.save
  end

  private
  def profile_url_cannot_be_invalid_battlenet_url
    return if profile_url.blank? || BattleNetInfo.new(profile_url).valid_url?
    errors.add(:profile_url, I18n.t("activerecord.errors.profile.profile_url.invalid"))
  end
end
