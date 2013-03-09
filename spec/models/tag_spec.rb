require "spec_helper"

describe Tag do
  it "has a valid factory" do
    expect(create :tag).to be_valid
  end
end
