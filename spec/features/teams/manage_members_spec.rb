require 'spec_helper'

feature 'Manage team members' do
  given!(:leader) { create :user, email: 'leader@example.com' }
  given!(:user) { create :user, email: 'bob@example.com', username: 'Bob' }
  given!(:team) { create :team, name: 'Pirates', leader: leader }

  scenario 'leader can invite members as registered users' do
    sign_in_as 'leader@example.com', 'secret'
    visit '/teams/pirates/members'
    submit_invite_form_with_name 'bob@example.com'

    expect(page).to have_content I18n.t('teams.member_has_been_invited')
    expect(find('tr', text: 'Bob')).to have_content I18n.t('invite.statuses.pending')
  end

  scenario 'leader cannot invite unregistered users' do
    sign_in_as 'leader@example.com', 'secret'
    visit '/teams/pirates/members'
    submit_invite_form_with_name 'unknown'

    expect(page).to have_content I18n.t('invite.user.not_found')
    expect(page).to_not have_content 'unknown'
  end

  scenario 'only leader can view manage members page' do
    sign_in_as 'bob@example.com', 'secret'
    visit '/teams/pirates/members'

    expect(current_path).to eq '/teams/pirates'
    expect(page).to have_content I18n.t('unauthorized.manage.all')
  end
end

def submit_invite_form_with_name(name)
  within '#new_invite' do
    fill_in 'invite_name', with: name
    click_button I18n.t('helpers.submit.invite.create')
  end
end
