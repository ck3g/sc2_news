class Legacy::User < Legacy::Base
  self.table_name = "dbo.aspnet_Users"

  def import(membership)
    pass = rand(10000) + 100000
    user = ::User.where(email: membership.LoweredEmail).first_or_initialize
    user.password = pass
    user.password_confirmation = pass
    user.created_at = membership.CreateDate
    user.legacy_id = membership.UserId
    user.username = self.UserName
    if user.valid?
      user.save
    else
      log = Logger.new(LOG_FILE)
      log.error "\nUser not imported. Membership: #{membership.inspect}"
      log.error "ror user: #{user.inspect}"
      log.error "errors: #{user.errors.messages}"
    end

    user
  end
end
