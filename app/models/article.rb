class Article < ActiveRecord::Base
  CUTTER = "&lt;cut&gt;"
  DESC_LEN = 150

  attr_accessible :title, :body, :views_count, :tag_list,
    :published, :published_at, :sticky

  alias_attribute :deleted?, :deleted_at?

  acts_as_commentable
  acts_as_taggable

  belongs_to :user
  belongs_to :deleter, class_name: "User", foreign_key: :deleter_id

  validates :title, :body, :user_id, presence: true

  delegate :email, to: :user, prefix: true
  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :username, to: :user, prefix: false

  after_initialize :init_defaults

  scope :deleted, -> { where("deleted_at IS NOT NULL") }
  scope :published, -> { where(published: true) }
  scope :visible, -> { not_deleted.published }
  scope :not_deleted, -> { where("deleted_at IS NULL") }
  scope :not_deleted_or_mine, ->(user_id) {
    where("(deleted_at IS NULL) OR (deleted_at IS NOT NULL AND deleter_id = ?)", user_id)
  }
  scope :sticky, -> { where(sticky: true) }
  scope :regular, -> { where(sticky: false) }

  def self.top_tags(count)
    Article.tag_counts_on(:tags).sort_by(&:count).reverse.first(count)
  end

  def mark_as_deleted_by(user)
    update_column :deleted_at, DateTime.current
    update_column :deleter_id, user.id
  end

  def restore
    update_column :deleted_at, nil
    update_column :deleter_id, nil
  end

  def deleted_and_owned_by?(user)
    deleted_by?(user) && owned_by?(user)
  end

  def deleted_by?(user)
    deleted? && self.deleter_id == user.id
  end

  def owned_by?(user)
    self.user_id == user.id
  end

  def add_hit!
    increment! :views_count
  end

  def keywords
    self.tags.pluck(:name).sort.join(", ")
  end

  def description
    Sanitize.clean(self.body).strip.first(DESC_LEN)
  end

  def tweet(message)
    if can_tweet?
      Twitter.update(message)
      update_column :tweeted, true
    end
  end

  def can_tweet?
    published? && !tweeted? && Rails.env.production?
  end

  private
  def init_defaults
    self.published_at ||= created_at.presence || DateTime.current
  end
end
