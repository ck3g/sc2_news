require 'spec_helper'

describe ChatMessage do
  it "has a valid factory" do
    expect(create :chat_message).to be_valid
  end
end
