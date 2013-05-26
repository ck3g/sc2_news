class Invite < ActiveRecord::Base
  attr_accessible :leader_id, :status

  attr_accessor :name

  belongs_to :team
  belongs_to :user
  belongs_to :leader, class_name: 'User'

  validates :team, :user, :leader, presence: true
  validates :status, presence: true,
    inclusion: { in: %w[pending accepted rejected] }
  validates :user_id, uniqueness: { scope: :team_id,
    message: I18n.t('invite.user.already_invited') }

  validate :cannot_invite_unregistered_users
  validate :cannot_invite_self

  delegate :username, to: :leader, prefix: true
  delegate :name, to: :team, prefix: true
  delegate :team_leader?, to: :user, prefix: true

  after_validation :delegate_all_error_to_name

  state_machine :status, initial: :pending do
    event :accept do
      transition :pending => :accepted
    end

    event :reject do
      transition :pending => :rejected
    end

    after_transition any => :accepted do |invite|
      invite.user.team_id = invite.team_id unless invite.user_team_leader?
    end
  end

  def self.build_from_params(leader, params)
    invite = self.new
    invite.team = leader.current_team
    invite.leader = leader
    invite.user = User.find_by_username_or_email(params[:name])

    invite
  end

  private
  def cannot_invite_unregistered_users
    if self.user.blank?
      errors.add :name, I18n.t('invite.user.not_found')
    end
  end

  def delegate_all_error_to_name
    messages = []
    errors.each { |field, message| messages << message }
    messages.each { |message| errors.add :name, message }
  end

  def cannot_invite_self
    if self.leader_id == self.user_id
      errors.add :name, I18n.t('invite.user.cannot_invite_self')
    end
  end
end
