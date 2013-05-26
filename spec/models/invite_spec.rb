require 'spec_helper'

describe Invite do
  it 'has a valid factory' do
    expect(create :invite).to be_valid
  end

  describe '.associations' do
    it { should belong_to :team }
    it { should belong_to :user }
    it { should belong_to :leader }
  end

  describe '.validation' do
    context 'when valid' do
      subject { create :invite }
      it { should validate_presence_of :team }
      it { should validate_presence_of :user }
      it { should validate_presence_of :leader }
      it { should validate_presence_of :status }
      it do
        should ensure_inclusion_of(:status).
          in_array %w[pending accepted rejected]
      end
      it do
        should validate_uniqueness_of(:user_id).scoped_to(:team_id).
          with_message(I18n.t('invite.user.already_invited'))
      end
    end
  end

  describe '.build_from_params' do
    let!(:leader) { create :user }
    let!(:team) { create :team, leader: leader }
    let!(:bob) { create :user, username: 'Bob' }

    subject { Invite.build_from_params(leader, name: 'bob') }

    it { should be_kind_of Invite }
    its(:persisted?) { should be_false }
    its(:team) { should eq team }
    its(:leader) { should eq leader }
    its(:user) { should eq bob }

    context 'when name is blank' do
      subject { Invite.build_from_params(leader, name: '') }

      its(:user) { should be_nil }
    end
  end

  describe '#accept' do
    let!(:user) { create :user }
    let!(:team) { create :team }
    let!(:invite) { create :invite, user: user, team: team }
    context 'when user isnt in team' do
      it 'joins the team' do
        expect { invite.accept }.to change { user.team }
      end
    end

    context 'when user already in team' do
      context 'as leader' do
        let!(:team2) { create :team, leader: user }

        it 'cant joins the another team' do
          expect { invite.accept }.to_not change { user.team }
        end
      end

      context 'as member' do
        let!(:team2) { create :team, members: [user] }
        it 'joins the another team' do
          expect { invite.accept }.to change { user.team }
        end
      end
    end
  end
end
