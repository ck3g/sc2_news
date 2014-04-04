require 'spec_helper'

feature 'Leaving team' do
  given!(:leader) { create :user, email: 'leader@example.com' }
  given!(:bobby) { create :user, email: 'bob@example.com', username: 'Bobby' }
  given!(:team) do
    create :team, name: 'Pirates', leader: leader, members: [bobby]
  end
  given!(:bobby_invite) do
    create :accepted_invite, user: bobby, leader: leader, team: team
  end

  scenario 'every member can leave the team' do
    pending 'The teams temporary disabled'
    sign_in_as 'bob@example.com', 'secret'
    visit '/teams/pirates'
    click_leave_team_link

    should_see_you_left_the_team_flash_message
    should_not_see_leave_team_link_anymore
  end

  scenario 'leader can kick member from the team' do
    pending 'The teams temporary disabled'
    sign_in_as 'leader@example.com', 'secret'
    visit '/teams/pirates/members'
    click_kick_user_from_team

    should_see_you_kicked_user_flash
    should_not_see_user_in_list_anymore
  end

  context 'when there is unaccepted member' do
    given!(:bill) { create :user, username: 'Bill' }
    given!(:bill_invite) do
      create :invite, user: bill, leader: leader, team: team
    end

    scenario 'leader cannot kick unaccepted member' do
      pending 'The teams temporary disabled'
      sign_in_as 'leader@example.com', 'secret'
      visit '/teams/pirates/members'

      should_not_see_button_kick_within_pending_member
    end
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

def click_kick_user_from_team
  within 'tr', text: 'Bobby' do
    click_link I18n.t('teams.kick_member')
  end
end

def should_see_you_kicked_user_flash
  expect(page).to have_content(
    I18n.t('teams.you_have_kicked', user: 'Bobby'))
end

def should_not_see_user_in_list_anymore
  within 'table' do
    expect(page).to_not have_content 'Bobby'
  end
end

def should_not_see_button_kick_within_pending_member
  expect(find('tr', text: 'Bill')).
    to_not have_selector 'a', text: I18n.t('teams.kick_member')
end

