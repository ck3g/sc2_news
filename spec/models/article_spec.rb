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
end
