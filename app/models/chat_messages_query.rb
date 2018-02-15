class ChatMessagesQuery
  def initialize(user)
    @user = user
  end

  def self.recent(user)
    new(user).recent
  end

  def recent
    ChatMessage.where.not(user_id: skip_user_ids).includes(:user).recent
  end

  private

  attr_reader :user

  def skip_user_ids
    banned_user_ids - [user.try(:id)]
  end

  def banned_user_ids
    User.with_roles(:shadow_ban_chat).pluck(:id)
  end
end
