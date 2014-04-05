require 'spec_helper'

feature "Sign up" do
  scenario 'can sign up using valid credentials' do
    visit new_user_registration_path
    within "#new_user" do
      fill_in 'user_username', with: 'username'
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button I18n.t(:do_sign_up)
    end

    expect(User.count).to eq 1
    expect(page).to have_content I18n.t('devise.registrations.signed_up')
  end
end
