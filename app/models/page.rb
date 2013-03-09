class Page < ActiveRecord::Base
  attr_accessible :content, :description, :enabled, :keywords, :permalink, :title

  validates :permalink, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
end
