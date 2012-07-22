class Article < ActiveRecord::Base

  acts_as_commentable

  has_and_belongs_to_many :tags

  belongs_to :user
  validates :title, :body, :user, presence: true

  scope :recent, order("created_at DESC").joins(:user)

  def self.by_tag(tag)
    tag = Tag.find_by_name(tag)
    raise ActiveRecord::RecordNotFound if tag.nil?
    tag.articles.recent.all
  end


end
