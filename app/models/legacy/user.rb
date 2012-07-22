class Legacy::User < Legacy::Base
  set_table_name "dbo.aspnet_Users"

  def import(membership)
    pass = rand(10000) + 100000
    user = User.find_or_create_by_email(membership.Email)
    user.password = pass
    user.password_confirmation = pass
    user.created_at = membership.CreateDate
    user.old_id = membership.UserId
    user.user_name = self.UserName
    user.save

    user.reload
  end
end
