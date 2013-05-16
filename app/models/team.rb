class Team < ActiveRecord::Base
  attr_accessible :description, :logo, :name, :slug

  belongs_to :leader, class_name: 'User'
  has_many :members, class_name: 'User', foreign_key: 'team_id'

  validates :leader_id, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
