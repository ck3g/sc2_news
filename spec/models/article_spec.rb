require 'spec_helper'

describe Article do
  it "has a valid factory" do
    expect(create :article).to be_valid
  end

  describe ".associations" do
    it { should belong_to :user }
    it { should have_many :comments }
    it { should belong_to :deleter }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :article }
      it { should validate_presence_of :title }
      it { should validate_presence_of :body }
      it { should validate_presence_of :user_id }
    end
  end

  describe "initialize" do
    it "sets the default values" do
      Article.any_instance.should_receive(:init_defaults)
      build :article
    end
  end

  describe "meta tags" do
    let!(:article) do
        create(:article, tag_list: "terran, zerg")
    end

    describe "#keywords" do
      it "collect keywords" do
        expect(article.keywords).to eq "terran, zerg"
      end
    end

    describe "#description" do
      context "when has body" do
        it "collect description" do
          article.body = "<p>#{ "huge article's body" * 200 }</p>"
          expect(article.description).to eq article.body[3..152]
        end
      end

      context "when empty body" do
        it "collect description" do
          article.body = ""
          expect(article.description).to eq ""
        end
      end
    end
  end

  describe "#mark_as_deleted_by" do
    let!(:article) { create :article }
    let!(:admin) { create :admin }

    it "marks article as deleted" do
      expect {
        article.mark_as_deleted_by admin
        article.reload
      }.to change { article.deleted_at }.from nil
    end
    it "remembers deleter" do
      expect {
        article.mark_as_deleted_by admin
        article.reload
      }.to change { article.deleter_id }.to admin.id
    end
  end

  describe "#restore" do
    let!(:deleted) { create :deleted_article }
    def restore
      deleted.restore
      deleted.reload
    end
    it "sets deleted_at to nil" do
      expect { restore }.to change { deleted.deleted_at }.to nil
    end

    it "sets deleter_id to nil" do
      expect { restore }.to change { deleted.deleter_id }.to nil
    end
  end

  describe ".scopes" do
    describe ".not_deleted_or_mine" do
      let(:user) { create :user }
      let!(:others) { create :article }
      let!(:deleted_others) { create :deleted_article }
      let!(:mine) { create :article, user: user }
      let!(:deleted_mine) { create :deleted_article, user: user, deleter: user }

      it "founds undeleted or mine" do
        expect(Article.not_deleted_or_mine(user.id).order(:id)).to eq [
          others, mine, deleted_mine
        ]
      end
    end
  end

  describe "#tweet" do
    let(:article) { build :article }
    context "when can tweet" do
      before do
        article.should_receive(:can_tweet?).and_return true
        Twitter.should_receive(:update).with "Tweet text"
        article.should_receive(:update_column).with(:tweeted, true)
      end

      it "updates twitter" do
        article.tweet "Tweet text"
      end
    end

    context "when cannot tweet" do
      before do
        article.should_receive(:can_tweet?).and_return false
        Twitter.should_not_receive(:update)
        article.should_not_receive(:update_column).with(:tweeted, true)
      end

      it "dont updates twitter" do
        article.tweet "Tweet text"
      end
    end
  end

  describe "#can_tweet?" do
    let(:article) { create :article }

    context "when article isn't published" do
      let(:article) { create :unpublished_article }
      it { expect(article.can_tweet?).to be_false }
    end

    context "when already tweeted" do
      before { article.stub(:tweeted?).and_return true }
      it { expect(article.can_tweet?).to be_false }
    end

    context "when rails env isn't production" do
      before { article.stub(:tweeted?).and_return false }
      it { expect(article.can_tweet?).to be_false }
    end

    context "when not tweeted, published and production" do
      before do
        Rails.stub_chain(:env, :production?).and_return true
      end
      it { expect(article.can_tweet?).to be_true }
    end
  end
end
