require 'spec_helper'

feature 'View profile' do
  given!(:user) { create :user, username: 'user' }
  given!(:profile) { create :profile, user: user }

  context 'when user in team' do
    given!(:team) { create :team, name: 'Pirates', members: [user] }

    scenario "can display user's team" do
      visit '/profile/user'
      click_link 'Pirates'

      expect(current_path).to eq '/teams/pirates'
    end
  end

  context 'when user not in team' do
    scenario "cannot display user's team" do
      visit '/profile/user'

      expect(page).to_not have_selector 'a', text: 'Pirates'
    end
  end
end
