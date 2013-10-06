require 'spec_helper'

feature 'Invites' do
  given!(:superman) { create :user, username: 'Superman' }
  given!(:justice_league) do
    create :team, name: 'Justice League', leader: superman
  end
  given!(:batman) do
    create :user, username: 'Batman', email: 'bruce.wayne@batman.com'
  end
  given!(:green_arrow) do
    create :user, username: 'GreenArrow', email: 'oliver.queen@unidac.ind'
  end

  given!(:batman_invite) do
    create :invite, leader: superman, user: batman, team: justice_league
  end

  scenario 'invited user can see his invites only' do
    pending "Teams functionality has been disabled"
    sign_in_as 'bruce.wayne@batman.com', 'secret'
    visit '/'
    click_link I18n.t(:my_invites)

    expect_to_see_invites_page_title
    expect(page).to_not have_content I18n.t('invites.you_aint_invited_yet')
    expect(page).to have_content you_got_invited_message
    expect_to_see_status_within_table_row 'pending'
  end

  scenario 'invited user can accept invite' do
    sign_in_as 'bruce.wayne@batman.com', 'secret'
    visit '/invites'
    click_invite_button 'accept'

    expect_to_see_status_within_table_row 'accepted'
    expect_to_not_see_button 'accept'
    expect_to_not_see_button 'reject'
  end

  scenario 'invited user can reject invite' do
    sign_in_as 'bruce.wayne@batman.com', 'secret'
    visit '/invites'
    click_invite_button 'reject'

    expect_to_see_status_within_table_row 'rejected'
    expect_to_not_see_button 'accept'
    expect_to_not_see_button 'reject'
  end

  context 'when user is leader of another team' do
    given!(:ironman) do
      create :user, username: 'ironman', email: 'tony@stark.ind'
    end
    given!(:avengers) { create :team, name: 'Avengers', leader: ironman }
    given!(:ironman_invite) do
      create :invite, team: justice_league, leader: superman, user: ironman
    end

    scenario 'cannot accept invite' do
      sign_in_as 'tony@stark.ind', 'secret'
      visit '/invites'

      expect_to_not_see_button 'accept'
    end
  end

  scenario 'not invited person can see "Aint invited" message' do
    sign_in_as 'oliver.queen@unidac.ind', 'secret'
    visit '/invites'

    expect(page).to have_content I18n.t('invites.you_aint_invited_yet')
  end

  scenario 'guests cannot visit invites page' do
    visit '/invites'
    expect(current_path).to eq '/'
    expect(page).to have_content I18n.t('unauthorized.manage.all')
  end
end

def expect_to_see_invites_page_title
  within 'h1' do
    expect(page).to have_content I18n.t(:my_invites)
  end
end

def you_got_invited_message
  "Superman #{ I18n.t('invites.you_got_invited_in') } Justice League"
end

def click_invite_button(status)
  within 'tr', text: you_got_invited_message do
    click_link I18n.t("invite.#{ status }")
  end
end

def expect_to_see_status_within_table_row(status)
  expect(find('tr', text: you_got_invited_message)).
    to have_content I18n.t("invite.statuses.#{ status }")
end

def expect_to_not_see_button(status)
  expect(page).to_not have_selector 'a', text: I18n.t("invite.#{ status }")
end

