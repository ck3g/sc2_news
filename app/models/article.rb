class Article < ActiveRecord::Base
  CUTTER = "&lt;cut&gt;"

  attr_accessible :title, :body, :views_count, :tag_list, :published, :published_at

  acts_as_commentable
  acts_as_taggable

  belongs_to :user

  validates :title, :body, :user_id, presence: true

  delegate :email, to: :user, prefix: true
  delegate :name, to: :user, prefix: true, allow_nil: true

  after_initialize :init_defaults

  def self.top_tags(count)
    Article.tag_counts_on(:tags).sort_by(&:count).reverse.first(count)
  end

  private
  def init_defaults
    self.published_at ||= created_at.presence || DateTime.current
  end
end
