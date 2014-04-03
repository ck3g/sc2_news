require 'spec_helper'

describe UsersController do
  login_admin

  let!(:alice) { create :user, username: "Alice" }

  describe "GET #index" do
    before do
      User.should_receive(:page).and_return [alice]
      get :index
    end
    it { expect(assigns[:users]).to eq [alice] }
    it { should respond_with :success }
    it { should render_template :index }
  end

  describe "GET #edit" do
    before { get :edit, id: alice }
    it { expect(assigns[:user]).to eq alice }
    it { should respond_with :success }
    it { should render_template :edit }
  end

  describe "PUT #update" do
    context "when valid attributes" do
      before do
        put :update, id: alice, user: attributes_for(:user, roles: ["admin", "writer"])
      end

      it { expect(assigns[:user]).to eq alice }
      it { should redirect_to users_path }
      it { should set_the_flash[:notice].to I18n.t(:updated_successfully) }
      it { expect(alice.reload.roles).to eq [:admin, :writer] }
    end
  end
end
