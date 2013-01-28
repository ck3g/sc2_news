require 'spec_helper'

describe Comment do
  it "has a valid factory" do
    expect(create :comment).to be_valid
  end
end
