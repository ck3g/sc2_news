class ChatMessage < ActiveRecord::Base
  belongs_to :user

  validates :body, :user_id, presence: true

  def self.recent
    joins(:user).order("chat_messages.created_at DESC").limit(20).reverse
  end

end
