require 'spec_helper'

describe Article do
  it "has a valid factory" do
    expect(create :article).to be_valid
  end

  describe ".associations" do
    it { should belong_to :user }
    it { should have_many :comments }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :article }
      it { should validate_presence_of :title }
      it { should validate_presence_of :body }
      it { should validate_presence_of :user_id }
    end
  end
end
