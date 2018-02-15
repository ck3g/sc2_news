require 'spec_helper'

RSpec.describe ChatMessagesQuery do
  describe ".recent" do
    subject { described_class.recent(user) }

    let!(:normal_user) { create :user }
    let!(:banned_user) { create :shadow_ban_chat }

    let!(:normal_message) { create :chat_message, user: normal_user }
    let!(:banned_message) { create :chat_message, user: banned_user }

    context "for guest user" do
      let(:user) { nil }

      it "returns all messages except from banned users" do
        expect(subject).to eq [normal_message]
      end
    end

    context "for banned user" do
      let(:user) { banned_user }

      it "returns all messages" do
        expect(subject).to eq [normal_message, banned_message]
      end
    end
  end
end
