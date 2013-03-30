class Legacy::Comment < Legacy::Base
  self.table_name = "Comments"

  def import(article)
    user = User.where(legacy_id: self.author_id).first
    comment = article.comments.new(comment: self.body,
                                   ip_address: self.ip_address)
    comment.user_id = user.try(:id)
    comment.created_at = self.created_at
    comment.save!
  end
end
