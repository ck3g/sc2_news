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
    :created_at, :legacy_id, :username, :roles, :username, :login

  attr_accessor :login

  has_many :articles, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_one :profile, dependent: :destroy
  has_many :deleted_articles, dependent: :nullify, class_name: "Article", foreign_key: :deleter_id
  has_many :chat_messages, dependent: :destroy
  belongs_to :team
  has_many :teams, foreign_key: 'leader_id'

  validates :username, presence: true, uniqueness: true

  alias_attribute :name, :username

  after_create :create_profile

  scope :by_login, ->(login) { where(["lower(username) = :value OR lower(email) = :value", value: login.downcase]) }
  scope :term, ->(term) { where(["username ILIKE :value OR email ILIKE :value", value: "%#{term}%"]) }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).by_login(login).first
    else
      where(conditions).first
    end
  end

  def self.admin?(user)
    user && user.admin?
  end

  ROLES.each do |role|
    define_method "#{role}?" do
      self.roles?(role)
    end
  end

  def in_team?
    current_team.present?
  end

  def current_team
    team || teams.first
  end
end
