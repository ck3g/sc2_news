class Legacy::Comment < Legacy::Base
  self.table_name = "Comments"

  def import(article)
    user = User.find_by_legacy_id(self.author_id)
    article.comments.new(comment: self.body, ip_address: self.ip_address)
    article.user_id = user.try(:id)
    article.created_at = self.created_at
    article.save
  end
end
