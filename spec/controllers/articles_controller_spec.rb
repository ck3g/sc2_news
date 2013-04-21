require 'spec_helper'

describe ArticlesController do
  login_admin

  let(:article) { create :article }

  describe "GET #index" do
    let!(:old) { create :old_article, tag_list: "sc2, tournament" }
    let!(:very_old) { create :very_old_article, tag_list: "tournament, stream" }
    let!(:sticky) { create :sticky_article }

    before { get :index }
    it { should respond_with :success }
    it { should render_template :index }
    it { should assign_to(:sticky_articles).with [sticky] }
    it { should assign_to(:articles).with [article, old, very_old] }

    context "when selected by tags" do
      before { get :index, tagged_with: "tournament" }
      it { should assign_to(:articles).with [old, very_old] }
    end
  end

  describe "GET #show" do
    def show_article
      get :show, id: article
      article.reload
    end
    before { show_article }
    it { should respond_with :success }
    it { should render_template :show }
    it { should assign_to(:article).with article }
    it { should assign_to(:comment).with_kind_of Comment }
    it { should assign_to(:comments).with article.comments }
    it "increment articles view count" do
      expect { show_article }.to change { article.views_count }.by(1)
    end
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
      before do
        Article.any_instance.should_receive(:tweet)
        unless example.metadata[:skip_before]
          post :create, article: attributes_for(:article)
        end
      end
      it { should assign_to(:article).with_kind_of Article }
      it { should redirect_to Article.last }
      it { should set_the_flash[:notice].to I18n.t(:created_successfully) }
      it "creates new article", skip_before: true do
        expect {
          post :create, article: attributes_for(:article)
        }.to change(Article, :count).by(1)
      end
      it "saves the user's ip" do
        expect(Article.last.ip_address).to eq "192.168.0.1"
      end
    end

    context "when invalid attributes" do
      before do
        Article.any_instance.should_not_receive(:tweet)
        unless example.metadata[:skip_before]
          post :create, article: attributes_for(:invalid_article)
        end
      end
      it { should render_template :new }
      it { should assign_to(:article).with_kind_of Article }
      it "don't creates new article", skip_before: true do
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
      before do
        Article.any_instance.should_receive(:tweet)
        unless example.metadata[:skip_before]
          put :update, id: article, article: attributes_for(:article)
        end
      end
      it { should redirect_to article }
      it { should set_the_flash[:notice].to I18n.t(:updated_successfully) }
      it "changes the title", skip_before: true do
        expect {
          put :update, id: article, article: attributes_for(:article, title: "New Title")
          article.reload
        }.to change(article, :title).to("New Title")
      end
    end

    context "when invalid attributes" do
      before do
        Article.any_instance.should_not_receive(:tweet)
        unless example.metadata[:skip_before]
          put :update, id: article, article: attributes_for(:invalid_article)
        end
      end
      it { should assign_to(:article).with article }
      it { should render_template :edit }
      it "dont changes the title", skip_before: true do
        expect {
          put :update, id: article, article: attributes_for(:invalid_article, title: "Changed Title")
          article.reload
        }.to_not change(article, :title).to("Changed Title")
      end
    end
  end

  describe "DELETE #destroy" do
    def delete_article
      delete :destroy, id: article
    end
    before do
      DateTime.stub(:current).and_return DateTime.current
      article
      delete_article unless example.metadata[:skip_destroy]
    end

    it { should redirect_to articles_path }
    it { should assign_to(:article).with article }
    it "don't actually removes the article", skip_destroy: true do
      expect { delete_article }.to_not change { Article.count }
    end
    it "receives mark_as_deleted_by call", skip_destroy: true do
      Article.any_instance.should_receive(:mark_as_deleted_by)
      delete_article
    end
  end

  describe "PUT #restore" do
    let!(:deleted_article) { create :deleted_article }

    before do
      Article.any_instance.should_receive(:restore)
      put :restore, id: deleted_article
    end

    it { should redirect_to articles_path }
    it { should assign_to(:article).with deleted_article }
  end
end
