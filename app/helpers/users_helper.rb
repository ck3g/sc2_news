module UsersHelper
  def roles_list(user)
    user.roles.map { |role| t("activerecord.values.user.roles.#{role}") }.join(", ")
  end

  def collection_of_roles
    User::ROLES.map { |role| I18n.t("activerecord.values.user.roles.#{role}") }.zip(User::ROLES)
  end
end
