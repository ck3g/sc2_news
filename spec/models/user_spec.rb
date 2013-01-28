require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(create :user).to be_valid
  end

  describe ".indexes" do
    it { should have_db_index :roles }
  end

  describe ".associations" do
    it { should have_many :articles }
    it { should have_one :profile }
  end

  describe "#admin?" do
    let(:user) { create :admin }
    it { expect(user.admin?).to be_true }
  end

  describe "#editor?" do
    let(:user) { create :editor }
    it { expect(user.editor?).to be_true }
  end

  describe "#writer?" do
    let(:user) { create :writer }
    it { expect(user.writer?).to be_true }
  end

  describe "#streamer?" do
    let(:user) { create :streamer }
    it { expect(user.streamer?).to be_true }
  end
end
