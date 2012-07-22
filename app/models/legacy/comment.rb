class Legacy::Comment < Legacy::Base
  self.table_name = "Comments"

  def import(article)
    user = User.find_by_legacy_id(self.author_id)
    article.comments.create(comment: self.body,
                            user_id: user.try(:id),
                            created_at: self.created_at,
                            ip_address: self.ip_address)
  end
end
