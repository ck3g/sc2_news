require 'spec_helper'

feature 'Edit team data' do
  given!(:user) { create :user, email: 'user@example.com' }
  given!(:leader) { create :user, email: 'leader@example.com' }
  given!(:team) { create :team, leader: leader, slug: 'awesome-team' }

  scenario 'leader can edit own team' do
    pending 'The teams temporary disabled'
    sign_in_as 'leader@example.com', 'secret'
    visit '/teams/awesome-team'
    follow_edit_team_link
    fill_in_edit_form_with_new_data

    expect(current_path).to eq '/teams/new-team-name'
    expect(page).to have_content 'New team name'
    expect(page).to have_content I18n.t(:updated_successfully)
  end

  scenario 'leader can disband team' do
    pending 'The teams temporary disabled'
    sign_in_as 'leader@example.com', 'secret'
    visit '/teams/awesome-team'
    follow_disband_team_link

    expect(current_path).to eq '/'
    expect(page).to have_content I18n.t('teams.has_been_disbanded')
  end

  scenario 'user cannot see edit and disband team link' do
    pending 'The teams temporary disabled'
    sign_in_as 'user@example.com', 'secret'
    visit '/teams/awesome-team'

    doesnt_see_edit_team_link
  end

  scenario 'user cannot edit ally team' do
    pending 'The teams temporary disabled'
    sign_in_as 'user@example.com', 'secret'
    visit edit_team_path(team)

    expect(current_path).to_not eq edit_team_path(team)
    expect(page).to have_content I18n.t('unauthorized.edit.team')
  end
end

def follow_edit_team_link
  within '.manage-button-wrapper' do
    click_link I18n.t('teams.edit')
  end
end

def follow_disband_team_link
  within '.manage-button-wrapper' do
    click_link I18n.t('teams.disband')
  end
end

def fill_in_edit_form_with_new_data
  within "#edit_team_#{ team.id }" do
    fill_in 'team_name', with: 'New team name'
    fill_in 'team_slug', with: 'new-team-name'
    click_button I18n.t('helpers.submit.team.update')
  end
end

def doesnt_see_edit_team_link
  expect(page).to_not have_selector('a', text: I18n.t('teams.edit'))
end

def doesnt_see_disband_team_link
  expect(page).to_not have_selector('a', text: I18n.t('teams.disband'))
end

