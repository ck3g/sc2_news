require 'spec_helper'

feature 'Leaving team' do
  given!(:member) { create :user, email: 'user@example.com' }
  given!(:team) { create :team, name: 'Pirates', members: [member] }

  scenario 'every member can leave the team' do
    sign_in_as 'user@example.com', 'secret'
    visit '/teams/pirates'
    click_leave_team_link

    should_see_you_left_the_team_flash_message
    should_not_see_leave_team_link_anymore
  end
end

def click_leave_team_link
  within '.manage-button-wrapper' do
    click_link I18n.t('teams.leave')
  end
end

def should_not_see_leave_team_link_anymore
  expect(page).to_not have_selector 'a', text: I18n.t('teams.leave')
end

def should_see_you_left_the_team_flash_message
  expect(page).to have_content I18n.t('teams.you_left_the_team')
end
