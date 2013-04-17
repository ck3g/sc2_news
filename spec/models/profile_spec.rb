require 'spec_helper'

describe Profile do
  let(:zakk_url) { "http://eu.battle.net/sc2/en/profile/267901/1/Zakk/" }
  let(:google_url) { "http://google.com" }

  it "has a valid factory" do
    expect(create :profile).to be_valid
  end

  describe ".associations" do
    it { should belong_to :user }
    it { should belong_to :country }
  end

  describe ".validations" do
    subject { create :profile }
    context "when valid" do
      it { should allow_value(zakk_url).for :profile_url }
      it { should allow_value("").for :profile_url }
    end

    context "when invalid" do
      it { should_not allow_value(google_url).for(:profile_url).with_message(I18n.t("activerecord.errors.profile.profile_url.invalid")) }
    end
  end

  describe "#sync!" do
    let!(:zakk) { create :profile, profile_url: zakk_url }
    let(:portrait_style) { "background: url('bnet/0-90.jpg') -450px -90px no-repeat; width: 90px; height: 90px;" }

    before do
      player = mock BattleNetInfo
      BattleNetInfo.should_receive(:new).with(zakk_url).and_return(player)
      player.stub(:to_hash).and_return({
        server: "eu",
        player_name: "Zakk",
        achievement_points: 2450,
        points: 74,
        wins: 5,
        rank: 2,
        league: "none_4"
      })
      player.stub(:portrait_html_style).with("/assets/bnet/").and_return(portrait_style)
      zakk.should_receive(:profile_url_cannot_be_invalid_battlenet_url).and_return(nil)
    end

    it { zakk.sync! }
    it "changes bnet_server" do
      expect { zakk.sync! }.to change { zakk.bnet_server }.to "eu"
    end
    it "changes bnet_name" do
      expect { zakk.sync! }.to change { zakk.bnet_name }.to "Zakk"
    end
    it "changes the achievement points" do
      expect { zakk.sync! }.to change { zakk.achievements }.to 2450
    end
    it "changes the points" do
      expect { zakk.sync! }.to change { zakk.points }.to 74
    end
    it "changes the wins" do
      expect { zakk.sync! }.to change { zakk.wins }.to 5
    end
    it "changes the rank" do
      expect { zakk.sync! }.to change { zakk.rank }.to 2
    end
    it "changes the league" do
      expect { zakk.sync! }.to change { zakk.league }.to "none_4"
    end
    it "changes the points" do
      expect { zakk.sync! }.to change { zakk.avatar_style }.to portrait_style
    end
    it "changes the synchronized_at" do
      expect { zakk.sync! }.to change { zakk.synchronized_at }
    end
  end

  describe "#has_played_games?" do
    context "when has played games" do
      it { expect(build(:profile, wins: 5).has_played_games?).to be_true }
    end

    context "when has no played games" do
      it { expect(build(:profile).has_played_games?).to be_false }
    end
  end
end
