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
    before do
      ActionDispatch::Request.any_instance.stub(:remote_ip).and_return("192.168.0.1")
    end
    context "when valid attributes" do
      before { post :create, article: attributes_for(:article) }
      it { should assign_to(:article).with_kind_of Article }
      it { should redirect_to Article.last }
      it { should set_the_flash[:notice].to I18n.t(:created_successfully) }
      it "creates new article" do
        expect {
          post :create, article: attributes_for(:article)
        }.to change(Article, :count).by(1)
      end
      it "saves the user's ip" do
        expect(Article.last.ip_address).to eq "192.168.0.1"
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

  describe "GET #edit" do
    before { get :edit, id: article }
    it { should respond_with :success }
    it { should render_template :edit }
    it { should assign_to(:article).with article }
  end

  describe "PUT #update" do
    context "when valid attributes" do
      before { put :update, id: article, article: attributes_for(:article) }
      it { should redirect_to article }
      it { should set_the_flash[:notice].to I18n.t(:updated_successfully) }
      it "changes the title" do
        expect {
          put :update, id: article, article: attributes_for(:article, title: "New Title")
          article.reload
        }.to change(article, :title).to("New Title")
      end
    end

    context "when invalid attributes" do
      before { put :update, id: article, article: attributes_for(:invalid_article) }
      it { should assign_to(:article).with article }
      it { should render_template :edit }
      it "dont changes the title" do
        expect {
          put :update, id: article, article: attributes_for(:invalid_article, title: "Changed Title")
          article.reload
        }.to_not change(article, :title).to("Changed Title")
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
