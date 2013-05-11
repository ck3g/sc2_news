require 'spec_helper'

describe OurFriend do
  it 'has a valid factory' do
    expect(create :our_friend).to be_valid
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :our_friend }
      it { should validate_presence_of :title }
      it { should validate_presence_of :url }
    end
  end

  describe '.scopes' do
    describe '.visible' do
      let!(:visible) { create :our_friend }
      let!(:hidden) { create :hidden_our_friend }

      it 'returns only visible friends' do
        expect(OurFriend.visible).to eq [visible]
      end
    end
  end
end
