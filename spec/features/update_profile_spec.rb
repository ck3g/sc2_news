require 'spec_helper'

feature 'Update profile' do
  given!(:user) { create :user, email: 'user@example.com', username: 'user' }
  given!(:profile) { create :profile, user: user }

  scenario 'can account information' do
    sign_in_as 'user@example.com', 'secret'
    visit edit_user_registration_path

    within '#edit_user' do
      fill_in 'user_username', with: 'Bruce'
      fill_in 'user_current_password', with: 'secret'
      click_button I18n.t('helpers.submit.user.update')
    end

    within '.nav-collapse' do
      expect(page).to have_content 'Bruce'
    end
  end
end
