require 'spec_helper'

describe ArticlesController do
  login_admin

  let(:article) { create :article }

  describe "GET #index" do
    before { get :index }
    it { should respond_with :success }
    it { should render_template :index }
    it { should assign_to(:articles).with [article] }
  end

  describe "GET #show" do
    before { get :show, id: article }
    it { should respond_with :success }
    it { should render_template :show }
    it { should assign_to(:article).with article }
  end

  describe "GET #new" do
    before { get :new }
    it { should respond_with :success }
    it { should render_template :new }
    it { should assign_to(:article).with_kind_of Article }
  end

  describe "POST #create" do
    context "when valid attributes" do
      before { post :create, article: attributes_for(:article) }
      it { should assign_to(:article).with_kind_of Article }
      it { should redirect_to articles_path }
      it { should set_the_flash[:notice].to I18n.t(:created_successfully) }
      it "creates new article" do
        expect {
          post :create, article: attributes_for(:article)
        }.to change(Article, :count).by(1)
      end
    end

    context "when invalid attributes" do
      before { post :create, article: attributes_for(:invalid_article) }
      it { should render_template :new }
      it { should assign_to(:article).with_kind_of Article }
      it "don't creates new article" do
        expect {
          post :create, article: attributes_for(:invalid_article)
        }.to_not change(Article, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      article
      unless example.metadata[:skip_destroy]
        delete :destroy, id: article
      end
    end

    it { should redirect_to articles_path }
    it { should assign_to(:article).with article }
    it "removes the article", skip_destroy: true do
      expect {
        delete :destroy, id: article
      }
    end
  end
end
