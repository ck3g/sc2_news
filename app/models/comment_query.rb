class CommentQuery
  def initialize(relation = Comment)
    @relation = relation.includes(:user, :commentable)
  end

  def list
    @relation.order("comments.created_at").scoped
  end
end
