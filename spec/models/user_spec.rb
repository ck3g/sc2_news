require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(create :user).to be_valid
  end

  describe ".indexes" do
    it { should have_db_index :roles }
  end

  describe ".associations" do
    it { should have_many(:articles).dependent(:nullify) }
    it { should have_many(:comments).dependent(:nullify) }
    it { should have_one(:profile).dependent(:destroy) }
    it { should have_many(:deleted_articles).dependent(:nullify) }
    it { should have_many(:chat_messages).dependent(:destroy) }
    it { should belong_to :team }
    it { should have_many(:teams) }
    it { should have_many(:invites).dependent(:destroy) }
    it { should have_many(:invitees).dependent(:destroy) }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :user }
      it { should validate_presence_of :email }
      it { should validate_presence_of :username }
      it { should validate_uniqueness_of :username }
    end
  end

  User::ROLES.each do |role|
    describe "##{role}?" do
      let(:user) { create role }
      it { expect(user.send("#{role}?")).to be_true }
    end
  end

  describe '#in_team?' do
    let(:user) { create :user }
    let(:team) { mock_model Team }

    subject { user.in_team? }

    context 'when has team' do
      before { user.should_receive(:current_team).and_return team }
      it { should be_true }
    end

    context 'when has not team' do
      before { user.should_receive(:current_team).and_return nil }
      it { should be_false }
    end
  end

  describe '#current_team' do
    let(:user) { create :user }

    subject { user.current_team }

    context 'when leader of the team' do
      let!(:team) { create :team, leader: user }
      it { should eq team }
    end

    context 'when team member' do
      let!(:team) { create :team }
      before { team.members << user }
      it { should eq team }
    end

    context 'otherwise' do
      it { should be_nil }
    end
  end

  describe '#invite_status' do
    let!(:user) { create :user }
    let!(:team) { create :team }

    subject { user.invite_status(team) }

    context 'when user has been invited' do
      before { create :invite, team: team, user: user }
      it { should eq 'pending' }
    end

    context 'when user wasnt invited' do
      it { should be_nil }
    end
  end

  describe '#invited_at' do
    let!(:user) { create :user }
    let!(:team) { create :team }

    subject { user.invited_at(team) }

    context 'when user has been invited' do
      let(:created_at) { Time.current }
      before do
        user.should_receive(:invite_for_team).and_return Invite.new
        Invite.any_instance.should_receive(:created_at).and_return created_at
      end
      it { should eq created_at }
    end

    context 'when user wasnt invited' do
      it { should be_nil }
    end
  end
end
