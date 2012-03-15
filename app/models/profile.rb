class Profile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :country_id, :race, :bnet_name, :bnet_server, :league, :experience, :first_name,
    :last_name, :details, :avatar_style, :achievements, :rank, :points, :wins, :loses, :win_rate,
    :profile_url, :synchronized_at
end
