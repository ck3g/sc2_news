require 'spec_helper'

describe Profile do
  it "has a valid factory" do
    expect(create :profile).to be_valid
  end

  describe ".associations" do
    it { should belong_to :user }
    it { should belong_to :country }
  end
end
