class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  attr_accessible :title, :comment, :ip_address

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates :comment, presence: true

  default_scope :order => 'created_at ASC'

  delegate :username, to: :user, prefix: false
end
