class Page < ActiveRecord::Base
  attr_accessible :content, :description, :enabled, :keywords, :permalink, :title

  validates :permalink, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  scope :enabled, -> { where(enabled: true) }

  def self.by_permalink(permalink)
    enabled.find_by_permalink(permalink)
  end

  def self.by_permalink!(permalink)
    enabled.find_by_permalink!(permalink)
  end
end
