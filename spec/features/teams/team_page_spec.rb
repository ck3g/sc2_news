require 'spec_helper'

feature 'Team page' do
  let!(:superman) { create :user, username: 'Superman' }
  let!(:justice_league) do
    create :team, name: 'Justice League', leader: superman
  end
  let!(:batman) { create :user, username: 'Batman', team: justice_league }

  scenario 'visitors can see members of viewed team' do
    pending 'The teams temporary disabled'
    visit '/teams/justice-league'
    within '#team-members' do
      within 'h3' do
        expect(page).to have_content I18n.t('teams.members')
      end
      expect(page).to have_content 'Superman'
      expect(page).to have_content 'Batman'
    end
  end
end
