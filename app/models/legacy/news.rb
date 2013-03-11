class Legacy::News < Legacy::Base
  self.table_name = "News"
  self.inheritance_column = :_type_disabled

  has_many :legacy_news_tags, class_name: "Legacy::NewsTag"
  has_many :legacy_tags, through: :legacy_news_tags

  def self.import(legacy_id)
    legacy = self.find_by_id(legacy_id)

    user = User.where(legacy_id: legacy.author_id).first
    article = Article.where(legacy_id: legacy_id).first_or_initialize

    article.title         = legacy.title
    article.body          = legacy.body
    article.user_id       = user.id
    article.views_count   = legacy.hits or 0
    article.created_at    = legacy.created_at or DateTime.current
    article.published_at  = legacy.created_at or DateTime.current
    article.updated_at    = legacy.modified_at or DateTime.current
    article.ip_address    = legacy.ip_address

    article.tag_list = legacy.legacy_tags.pluck(:name).join(", ")

    article.save
  end
end
