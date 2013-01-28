require "spec_helper"
require "cancan/matchers"

shared_examples "as writer" do
  let(:own_comment) { create :comment, user: user }
  let(:ally_comment) { create :comment, user: create(:user) }
  subject { Ability.new user }
  it { should be_able_to :all, Comment }
  it { should_not be_able_to :index, User }
  it { should_not be_able_to :manage, User }
  it { should be_able_to :read, Tag }
  it { should_not be_able_to :manage, Tag }
  it { should be_able_to :manage, own_comment }
  it { should_not be_able_to :manage, ally_comment }
end

shared_examples "manage Profiles" do
  let(:own_profile) { create :profile, user: user }
  let(:ally_profile) { create :profile }
  subject { Ability.new user }
  it { should be_able_to :manage, own_profile }
  it { should_not be_able_to :manage, ally_profile }
end

describe "Ability" do
  describe "as guest" do
    subject { Ability.new nil }
    it { should be_able_to :index, Article }
    it { should be_able_to :show, Article }
    it { should be_able_to :read, Tag }
    it { should_not be_able_to :manage, create(:comment) }
    it { should_not be_able_to :manage, create(:profile) }
  end

  describe "as admin" do
    subject { Ability.new create(:admin) }
    it { should be_able_to :all, Article }
    it { should be_able_to :all, Comment }
    it { should be_able_to :all, User }
    it { should be_able_to :all, Tag }
    it { should be_able_to :all, Profile }
  end

  describe "as editor" do
    let!(:user) { create :editor }
    subject { Ability.new user }
    it { should be_able_to :all, Comment }
    it { should_not be_able_to :index, User }
    it { should_not be_able_to :manage, User }
    it { should be_able_to :all, Tag }
    it_behaves_like "manage Profiles"
  end

  describe "as writer" do
    let!(:user) { create :writer }
    it_behaves_like "as writer"
    it_behaves_like "manage Profiles"
  end

  describe "as streamer" do
    let!(:user) { create :streamer }
    it_behaves_like "as writer"
    it_behaves_like "manage Profiles"
  end
end
