require 'spec_helper'

describe Profile do
  it "has a valid factory" do
    expect(create :profile).to be_valid
  end
end
