require 'spec_helper'

describe TeamMember do
  describe '#all' do
    let!(:team1) { create :team }
    let!(:team2) { create :team }
    let!(:user) { create :user }
    let!(:member) { create :user, team: team1 }
    let!(:invitee) { create :user }
    let!(:invite) { create :invite, user: invitee, team: team1 }

    it 'returns members or invited users for team1' do
      expect(TeamMember.new(team1).all).to eq [member, invitee]
    end

    it 'returns members or invited users for team2' do
      expect(TeamMember.new(team2).all).to eq []
    end
  end
end
