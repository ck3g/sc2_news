require 'spec_helper'

describe PagesController do
  login_admin

  describe "GET #index" do
    let!(:about) { create :about_page }
    let!(:jobs) { create :jobs_page }

    before { get :index }
    it { should assign_to(:pages).with [about, jobs] }
    it { should render_template :index }
    it { should respond_with :success }
  end

  describe "GET #show" do
    context "when permalink exists" do
      let!(:about) { create :about_page }
      before { get :show, permalink: "about" }
      it { should render_template :show }
      it { should assign_to(:page).with about }
      it { should respond_with :success }
    end

    context "when page disabled" do
      let!(:page) { create :disabled_page, permalink: "disabled" }
      before { get :show, permalink: "disabled" }
      it { should respond_with :not_found }
    end
  end

  describe "GET #new" do
    before { get :new }
    it { should render_template :new }
    it { should assign_to(:page).with_kind_of Page }
    it { should respond_with :success }
  end

  describe "POST create" do
    context "when valid" do
      def create_page
        post :create, page: attributes_for(:about_page)
      end
      before do
        create_page unless example.metadata[:skip_before]
      end
      it { should redirect_to pages_path }
      it { should set_the_flash[:notice].to I18n.t(:created_successfully) }
      it "creates the page", skip_before: true do
        expect { create_page }.to change(Page, :count).by(1)
      end
    end

    context "when invalid" do
      def try_to_create_page
        post :create, page: attributes_for(:invalid_page)
      end

      before do
        try_to_create_page unless example.metadata[:skil_before]
      end

      it { should assign_to(:page).with_kind_of Page }
      it { should render_template :new }
      it "not create the page", skip_before: true do
        expect { try_to_create_page }.to_not change(Page, :count)
      end
    end
  end

  describe "GET #edit" do
    let!(:about) { create :about_page }
    before { get :edit, id: about }
    it { should render_template :edit }
    it { should respond_with :success }
    it { should assign_to(:page).with about }
  end

  describe "PUT #update" do
    let!(:about) { create :about_page }
    context "when valid" do
      def update_title
        put :update, id: about, page: attributes_for(:about_page, title: "New")
      end
      before { update_title unless example.metadata[:skip_before] }
      it { should redirect_to pages_path }
      it { should set_the_flash[:notice].to I18n.t(:updated_successfully) }
      it "changes the title", skip_before: true do
        expect {
          update_title
          about.reload
        }.to change(about, :title).to "New"
      end
    end

    context "when invalid" do
      def update_title
        put :update, id: about, page: attributes_for(:invalid_page, title: "No way")
      end
      before { update_title unless example.metadata[:skip_before] }
      it { should render_template :edit }
      it "dont changes the title" do
        expect {
          update_title
          about.reload
        }.to_not change(about, :title)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:about) { create :about_page }

    def delete_page
      delete :destroy, id: about
    end

    before { delete_page unless example.metadata[:skip_before] }
    it { should redirect_to pages_path }
    it "deletes the page", skip_before: true do
      expect { delete_page }.to change(Page, :count).by(-1)
    end
  end
end
