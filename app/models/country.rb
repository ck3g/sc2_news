class Country < ActiveRecord::Base
  attr_accessible :name

  has_many :profiles, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
