class ArticleQuery
  def initialize(relation = Article)
    @relation = relation.includes(:user)
  end

  def list
    @relation.order("published_on DESC").scoped
  end
end
