require 'spec_helper'

describe ChatMessage do
  it "has a valid factory" do
    expect(create :chat_message).to be_valid
  end

  describe ".associations" do
    it { should belong_to :user }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :chat_message }
      it { should validate_presence_of :user_id }
      it { should validate_presence_of :body }
    end
  end
end
