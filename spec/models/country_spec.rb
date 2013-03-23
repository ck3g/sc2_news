require 'spec_helper'

describe Country do
  it "has a valid factory" do
    expect(create :country).to be_valid
  end

  describe ".associtations" do
    it { should have_many(:profiles).dependent(:nullify) }
  end

  describe ".validations" do
    context "when valid" do
      subject { create :country }
      it { should validate_presence_of :name }
      it { should validate_uniqueness_of :name }
    end
  end
end
