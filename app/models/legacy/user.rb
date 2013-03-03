class Legacy::User < Legacy::Base
  self.table_name = "dbo.aspnet_Users"

  def import(membership)
    pass = rand(10000) + 100000
    user = ::User.where(email: membership.Email.downcase).first_or_initialize
    user.password = pass
    user.password_confirmation = pass
    user.created_at = membership.CreateDate
    user.legacy_id = membership.UserId
    user.username = self.UserName
    user.save

    user.reload
  end
end
