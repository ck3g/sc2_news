class ChatMessage < ActiveRecord::Base



  belongs_to :user

  validates :body, :user, :presence => true

  def self.recent
    joins(:user).order("created_at Desc").limit(20).reverse
  end

end
