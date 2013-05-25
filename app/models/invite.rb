class Invite < ActiveRecord::Base
  attr_accessible :leader_id, :status

  attr_accessor :name

  belongs_to :team
  belongs_to :user
  belongs_to :leader, class_name: 'User'

  validates :team, :user, :leader, presence: true
  validates :status, presence: true,
    inclusion: { in: %w[pending accepted rejected] }
  validates :user_id, uniqueness: { scope: :team_id }

  after_validation :delegate_all_error_to_name

  state_machine :state, initial: :pending do
    event :accept do
      transition :pending => :accepted
    end

    event :reject do
      transition :pending => :rejected
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
  def delegate_all_error_to_name
    if self.user.blank?
      errors.add :name, I18n.t('invite.user.not_found')
    end
  end
end
