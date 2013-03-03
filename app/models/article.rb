class Article < ActiveRecord::Base
  CUTTER = "&lt;cut&gt;"

  attr_accessible :title, :body, :views_count, :tag_list

  acts_as_commentable
  acts_as_taggable

  belongs_to :user

  validates :title, :body, :user_id, presence: true

  delegate :email, to: :user, prefix: true
  delegate :name, to: :user, prefix: true, allow_nil: true

end
