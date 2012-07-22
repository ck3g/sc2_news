class Tag < ActiveRecord::Base

  has_and_belongs_to_many :articles

  validates :name, presence: true

end
