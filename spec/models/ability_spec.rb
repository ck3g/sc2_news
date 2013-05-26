require "spec_helper"
require "cancan/matchers"

shared_examples "as writer" do
  let(:own_comment) { create :comment, user: user }
  let(:ally_comment) { create :comment, user: create(:user) }
  let(:own_article) { create :deleted_article, user: user }
  let(:ally_article) { create :deleted_article, user: create(:user) }
  let(:own_deleted_article) { create :deleted_article, user: user, deleter: user }
  let(:ally_deleted_article) { create :deleted_article, user: create(:user), deleter: create(:user) }
  subject { Ability.new user }
  it { should be_able_to :crate, Article }
  it { should be_able_to :manage, own_article }
  it { should be_able_to :destroy, own_article }
  it { should_not be_able_to :manage, ally_article }
  it { should_not be_able_to :destroy, ally_article }
  it { should be_able_to :all, Comment }
  it { should_not be_able_to :index, User }
  it { should_not be_able_to :manage, User }
  it { should be_able_to :read, Tag }
  it { should_not be_able_to :manage, Tag }
  it { should be_able_to :manage, own_comment }
  it { should_not be_able_to :manage, ally_comment }
  it { should_not be_able_to :manage, Page }
  it { should be_able_to :manage, own_article }
  it { should_not be_able_to :manage, ally_article }
  it { should be_able_to [:manage, :restore], own_deleted_article }
  it { should_not be_able_to [:manage, :restore], ally_deleted_article }
  it { should_not be_able_to [:all], User }
  it { should_not be_able_to :destroy, ChatMessage }
  it { should be_able_to [:read, :create], Ckeditor::Picture }
  it { should be_able_to [:read, :create], Ckeditor::AttachmentFile }
  it { should_not be_able_to :destroy, Ckeditor::Picture }
  it { should_not be_able_to :destroy, Ckeditor::AttachmentFile }
  it { should_not be_able_to :manage, OurFriend }
end

shared_examples "manage Profiles" do
  let(:own_profile) { create :profile, user: user }
  let(:ally_profile) { create :profile }
  subject { Ability.new user }
  it { should be_able_to :manage, own_profile }
  it { should_not be_able_to :manage, ally_profile }
end

shared_examples "manage Teams" do
  let(:own_team) { create :team, leader: user }
  let(:ally_team) { create :team }
  subject { Ability.new user }
  it { should be_able_to :manage, own_team }
  it { should_not be_able_to :manage, ally_team }
  it { should be_able_to :manage, Invite }
  it { should be_able_to :accept, Invite }
  it { should be_able_to :reject, Invite }
end

shared_examples "as common user" do
  subject { Ability.new user }
  it { should be_able_to :index, Article }
  it { should be_able_to :show, create(:article) }
  it { should_not be_able_to :read, create(:unpublished_article) }
  it { should_not be_able_to :read, create(:deleted_article) }
  it { should be_able_to :read, Tag }
  it { should_not be_able_to :manage, Tag }
  it { should_not be_able_to :manage, Page }
  it { should_not be_able_to :restore, Article }
  it { should_not be_able_to :all, User }
  it { should_not be_able_to :all, ChatMessage }
  it { should_not be_able_to :all, Ckeditor::Picture }
  it { should_not be_able_to :all, Ckeditor::AttachmentFile }
  it { should be_able_to :read, Page }
  it { should_not be_able_to :manage, OurFriend }
  it { should be_able_to :index, Team }
  it { should be_able_to :show, Team }
end

describe "Ability" do
  describe "as guest" do
    let(:user) { nil }
    subject { Ability.new nil }
    it_behaves_like "as common user"
    it { should_not be_able_to :create, Comment }
    it { should_not be_able_to :manage, create(:profile) }
    it { should_not be_able_to :manage, Team }
    it { should be_able_to :index, Team }
    it { should be_able_to :show, Team }
    it { should_not be_able_to [:manage, :accept, :reject], Invite }
  end

  describe "as admin" do
    subject { Ability.new create(:admin) }
    it { should be_able_to :all, Article }
    it { should be_able_to :all, Comment }
    it { should be_able_to :all, User }
    it { should be_able_to :all, Tag }
    it { should be_able_to :all, Profile }
    it { should be_able_to :all, User }
    it { should be_able_to :all, ChatMessage }
    it { should be_able_to :manage, OurFriend }
  end

  describe "as editor" do
    let!(:user) { create :editor }
    subject { Ability.new user }
    it { should be_able_to :all, Comment }
    it { should_not be_able_to :index, User }
    it { should_not be_able_to :manage, User }
    it { should be_able_to :all, Tag }
    it { should be_able_to :manage, Page }
    it_behaves_like "manage Profiles"
    it { should be_able_to :all, ChatMessage }
    it { should be_able_to :manage, Ckeditor::Picture }
    it { should be_able_to :manage, Ckeditor::AttachmentFile }
    it { should be_able_to :manage, OurFriend }
    it_behaves_like "manage Teams"
  end

  describe "as writer" do
    let!(:user) { create :writer }
    it_behaves_like "as writer"
    it_behaves_like "manage Profiles"
    it_behaves_like "manage Teams"
  end

  describe "as streamer" do
    let!(:user) { create :streamer }
    it_behaves_like "as writer"
    it_behaves_like "manage Profiles"
    it_behaves_like "manage Teams"
  end

  describe "as registered user" do
    let!(:user) { create :user }
    subject { Ability.new user }
    it_behaves_like "as common user"
    it_behaves_like "manage Profiles"
    it_behaves_like "manage Teams"
    it { should be_able_to :create, Comment }
  end
end
