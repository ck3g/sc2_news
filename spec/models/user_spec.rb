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
  end

  User::ROLES.each do |role|
    describe "##{role}?" do
      let(:user) { create role }
      it { expect(user.send("#{role}?")).to be_true }
    end
  end
end
