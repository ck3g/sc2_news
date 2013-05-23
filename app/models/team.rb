class Team < ActiveRecord::Base
  extend FriendlyId

  SLUG_FORMAT = /\A[A-Za-z0-9\-_]+\z/i

  friendly_id :name, use: :slugged

  attr_accessible :description, :logo, :name, :slug

  belongs_to :leader, class_name: 'User'
  has_many :members, class_name: 'User', foreign_key: 'team_id'

  validates :leader_id, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true,
    format: { with: SLUG_FORMAT }

  def should_generate_new_friendly_id?
    new_record? && self.slug.blank?
  end
end
