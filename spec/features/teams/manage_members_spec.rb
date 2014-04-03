require 'spec_helper'

feature 'Manage team members' do
  given!(:leader) { create :user, email: 'leader@example.com' }
  given!(:user) { create :user, email: 'bob@example.com', username: 'Bob' }
  given!(:team) { create :team, name: 'Pirates', leader: leader }

  scenario 'leader can invite members as registered users' do
    pending 'The teams temporary disabled'
    sign_in_as 'leader@example.com', 'secret'
    visit '/teams/pirates/members'
    submit_invite_form_with_name 'bob@example.com'

    expect(page).to have_content I18n.t('teams.member_has_been_invited')
    should_see_pending_status_within_table_row
  end

  scenario 'leader cannot invite user twice' do
    pending 'The teams temporary disabled'
    create :invite, leader: leader, user: user, team: team

    sign_in_as 'leader@example.com', 'secret'
    visit '/teams/pirates/members'
    submit_invite_form_with_name 'bob@example.com'

    expect(page).to have_content I18n.t('invite.user.already_invited')
  end

  scenario 'leader cannot invite himself' do
    pending 'The teams temporary disabled'
    sign_in_as 'leader@example.com', 'secret'
    visit '/teams/pirates/members'
    submit_invite_form_with_name 'leader@example.com'

    expect(page).to have_content I18n.t('invite.user.cannot_invite_self')
  end

  scenario 'leader cannot invite unregistered users' do
    pending 'The teams temporary disabled'
    sign_in_as 'leader@example.com', 'secret'
    visit '/teams/pirates/members'
    submit_invite_form_with_name 'unknown'

    expect(page).to have_content I18n.t('invite.user.not_found')
    expect(page).to_not have_content 'unknown'
  end

  scenario 'only leader can view manage members page' do
    pending 'The teams temporary disabled'
    sign_in_as 'bob@example.com', 'secret'
    visit '/teams/pirates/members'

    expect(current_path).to eq '/'
    expect(page).to have_content I18n.t('unauthorized.manage.all')
  end
end

def submit_invite_form_with_name(name)
  within '#new_invite' do
    fill_in 'invite_name', with: name
    click_button I18n.t('helpers.submit.invite.create')
  end
end

def should_see_pending_status_within_table_row
  expect(find('tr', text: 'Bob')).
    to have_content I18n.t('invite.statuses.pending')
end
