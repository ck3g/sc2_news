require 'spec_helper'

feature 'Create team' do
  given!(:user) { create :user, email: "leader@team.com" }

  scenario 'User creates team with valid credentials' do
    quick_login 'leader@team.com', 'secret'
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

  scenario 'Guest cannot see create team page' do
    visit '/teams/new'
    page.should have_content I18n.t('unauthorized.manage.team')
  end
end
