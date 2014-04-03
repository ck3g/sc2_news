require 'spec_helper'

feature 'View list of the teams' do
  given!(:team) { create :team, name: 'Pirates', slug: 'pirates' }

  scenario 'user can see teams list' do
    pending 'The teams temporary disabled'
    visit '/'
    follow_teams_link_in_navbar
    should_come_to_teams_list_page
    should_see_teams_title
  end

  scenario 'user can visit team page from teams list' do
    pending 'The teams temporary disabled'
    visit '/teams'
    follow_link_in_teams_list
    should_come_to_team_page
    should_see_team_header
  end
end

def follow_teams_link_in_navbar
  within '.navbar-top' do
    click_link I18n.t('teams.list')
  end
end

def should_come_to_teams_list_page
  expect(current_path).to eq '/teams'
end

def should_see_teams_title
  within '#teams h2' do
    expect(page).to have_content I18n.t('teams.list')
  end
end

def follow_link_in_teams_list
  within '#teams' do
    click_link 'Pirates'
  end
end

def should_come_to_team_page
  expect(current_path).to eq '/teams/pirates'
end

def should_see_team_header
  within 'h2' do
    expect(page).to have_content 'Pirates'
  end
end
