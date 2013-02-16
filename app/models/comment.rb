class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  delegate :username, to: :user, prefix: false
end
