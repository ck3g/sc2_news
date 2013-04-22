class CommentQuery
  def initialize(relation = Comment)
    @relation = relation.includes(:user, :commentable).includes(:user => :profile)
  end

  def list
    @relation.order("comments.created_at").scoped
  end
end
