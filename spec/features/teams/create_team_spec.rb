require 'spec_helper'

feature 'Create team' do
  given!(:user) { create :user, email: "leader@team.com" }

  context 'when users signed in' do
    background do
      visit '/users/sign_in'
      within("#quick_sign_in") do
        fill_in 'user_login', with: 'leader@team.com'
        fill_in 'user_password', with: 'secret'
        click_button I18n.t(:do_sign_in)
      end
    end

    scenario 'User creates team with valid credentials' do
      visit '/teams/new'
      within("#new_team") do
        fill_in 'team_name', with: 'Justice League'
        fill_in 'team_slug', with: 'justice_league'
        click_button I18n.t('helpers.submit.team.create')
      end

      page.should have_content I18n.t(:created_successfully)
      within("h2") do
        page.should have_content 'Justice League'
      end
    end
  end

  context 'when user is guest' do
    scenario 'User cannot see create team page' do
      visit '/teams/new'
      page.should have_content I18n.t('unauthorized.manage.team')
    end
  end
end
