require 'spec_helper'

describe Comment do
  it "has a valid factory" do
    expect(create :comment).to be_valid
  end

  describe ".associations" do
    it { should belong_to :user }
    it { should belong_to :commentable }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :comment }
      it { should validate_presence_of :comment }
      it { should validate_presence_of :user_id }
    end
  end

end
