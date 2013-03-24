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
end
