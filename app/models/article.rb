class Article < ActiveRecord::Base
  CUTTER = "&lt;cut&gt;"

  acts_as_commentable

  has_and_belongs_to_many :tags
  belongs_to :user

  validates :title, :body, :user_id, presence: true

  delegate :email, to: :user, prefix: true
  delegate :name, to: :user, prefix: true, allow_nil: true

  scope :by_tag, ->(tag_name) { joins{tags}.where{ {tags.name => tag_name} } }

end
