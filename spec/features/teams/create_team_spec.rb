require 'spec_helper'

feature 'Create team' do
  given!(:user) { create :user, email: "leader@team.com" }

  scenario 'User creates team with valid credentials' do
    sign_in_as 'leader@team.com', 'secret'
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

  context 'when user already belongs to the team' do
    given!(:team) { create :team, leader: user }


    scenario 'cannot create the second team' do
      sign_in_as 'leader@team.com', 'secret'
      visit '/teams/new'
      page.current_path.should eq team_path(team)
      page.should have_content I18n.t('teams.cannot_create_while_in_team')
      page.should have_content team.name
    end
  end

  scenario 'Guest cannot see create team page' do
    visit '/teams/new'
    page.should have_content I18n.t('unauthorized.manage.team')
  end
end
