class User < ActiveRecord::Base
  ROLES = [:admin, :writer, :editor, :streamer]
  bitmask :roles, as: ROLES

  paginates_per 50

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :created_at, :legacy_id, :username, :roles

  has_many :articles, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_one :profile, dependent: :destroy
  has_many :deleted_articles, dependent: :nullify, class_name: "Article", foreign_key: :deleter_id

  alias_attribute :name, :username

  after_create :create_profile

  def self.admin?(user)
    user && user.admin?
  end

  ROLES.each do |role|
    define_method "#{role}?" do
      self.roles?(role)
    end
  end

end
