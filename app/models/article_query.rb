class ArticleQuery
  def initialize(relation = Article)
    @relation = relation.includes(:user, :tags)
  end

  def list
    @relation.
      order("published_date DESC").
      select("articles.*, COALESCE(articles.published_at, articles.created_at) as published_date")
  end
end
