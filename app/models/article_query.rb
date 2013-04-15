class ArticleQuery
  def initialize(relation = Article)
    @relation = relation.includes(:user, :tags)
  end

  def list
    @relation.
      order("COALESCE(articles.published_at, articles.created_at) DESC").
      scoped
  end
end
