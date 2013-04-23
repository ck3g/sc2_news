module UsersHelper
  def roles_list(user)
    user.roles.map do |role|
      t("activerecord.values.user.roles.#{ role }")
    end.join(", ")
  end

  def collection_of_roles
    User::ROLES.map do |role|
      t("activerecord.values.user.roles.#{ role }")
    end.zip(User::ROLES)
  end
end
