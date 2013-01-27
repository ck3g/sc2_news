class User < ActiveRecord::Base
  ROLES = [:admin, :writer, :editor, :streamer]
  bitmask :roles, as: ROLES

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :created_at, :legacy_id, :username

  has_many :articles
  has_one :profile, :dependent => :destroy

  alias_attribute :name, :username

  after_create :create_profile

  ROLES.each do |role|
    define_method "#{role}?" do
      self.roles?(role)
    end
  end
end
