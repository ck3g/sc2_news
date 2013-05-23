require 'spec_helper'

describe Team do
  it 'has a valid factory' do
    expect(create :team).to be_valid
  end

  describe '.associations' do
    it { should belong_to :leader }
    it { should have_many :members }
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :team }
      it { should validate_presence_of :leader_id }
      it { should validate_uniqueness_of :leader_id }
      it { should validate_presence_of :name }
      it { should validate_uniqueness_of :name }
      it { should validate_presence_of :slug }
      it { should validate_uniqueness_of :slug }
      it { should allow_value('valid-slug').for :slug }
    end

    context 'when invalid' do
      subject { build :team }
      it { should_not allow_value('Invalid slug').for :slug }
    end
  end
end
