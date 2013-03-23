require 'spec_helper'

describe ProfilesController do
  login_admin

  let!(:profile) { create :profile }

  describe "GET #show" do
    before { get :show, id: profile }
    it { should assign_to(:profile).with profile }
    it { should respond_with :success }
    it { should render_template :show }
  end

  describe "GET #edit" do
    before { get :edit, id: profile }
    it { should assign_to(:profile).with profile }
    it { should respond_with :success }
    it { should render_template :edit }
  end

  describe "PUT #update" do
    context "with valid attributes" do
      let(:profile_url) { "http://eu.battle.net/sc2/en/profile/267901/1/Zakk/" }

      def update_profile_url
        put :update, id: profile, profile: attributes_for(:profile, profile_url: profile_url)
        profile.reload
      end

      before { update_profile_url unless example.metadata[:skip_before] }

      it { should assign_to(:profile).with profile }
      it { should redirect_to profile }
      it { should set_the_flash[:notice].to I18n.t(:updated_successfully) }
      it "changes the profile url", skip_before: true do
        expect { update_profile_url }.to change { profile.profile_url }.to profile_url
      end
    end
  end

  describe "PUT #sync" do
    before do
      Profile.any_instance.should_receive(:sync!)
      put :sync, id: profile
    end

    it { should assign_to(:profile).with profile }
    it { should redirect_to profile }
  end
end
