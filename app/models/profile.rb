class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :country

  attr_accessible :country_id, :race, :bnet_name, :bnet_server, :league, :experience, :first_name,
    :last_name, :details, :avatar_style, :achievements, :rank, :points, :wins, :loses, :win_rate,
    :profile_url, :synchronized_at

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
end
