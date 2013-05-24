module FeatureLoginMacros
  def sign_in_as(email, password)
    visit '/'
    within("#quick_sign_in") do
      fill_in 'user_login', with: email
      fill_in 'user_password', with: password
      click_button I18n.t(:do_sign_in)
    end
  end
end
