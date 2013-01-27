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
end
