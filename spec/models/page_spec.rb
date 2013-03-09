require 'spec_helper'

describe Page do
  it "has a valid factory" do
    expect(create :page).to be_valid
  end

  describe ".validations" do
    subject { create :page }
    context "when valid" do
      it { should validate_presence_of :permalink }
      it { should validate_uniqueness_of :permalink }
      it { should validate_presence_of :title }
      it { should validate_uniqueness_of :title }
      it { should validate_presence_of :content }
    end
  end
end
