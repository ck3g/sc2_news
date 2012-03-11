class Article < ActiveRecord::Base

  acts_as_commentable

  before_create :default_values

  scope :recent, order("created_at DESC")

  has_and_belongs_to_many :tags, :class_name => Article::Tag

  belongs_to :user
  validates :title, :body, :user, :presence => true

  def default_values
    views_count = 0 if views_count.nil?
  end


  def self.by_tag(tag)
    tag = Article::Tag.find_by_title(tag)
    raise ActiveRecord::RecordNotFound if tag.nil?
    tag.articles.recent.all
  end


end
