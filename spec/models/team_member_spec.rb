require 'spec_helper'

describe TeamMember do
  describe '#all' do
    let!(:team) { create :team }
    let!(:user) { create :user }
    let!(:member) { create :user, team: team }
    let!(:invitee) { create :user }
    let!(:invite) { create :invite, user: invitee, team: team }

    it 'returns users in team or invited users' do
      expect(TeamMember.new(team).all).to eq [member, invitee]
    end
  end
end
