require 'spec_helper'

describe ArticlesController do
  login_admin

  describe "GET #index" do
    let(:article) { create :article }
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
    let(:article) do
      mock_model Article, comments: Comment, description: "", keywords: ""
    end
    let(:comment) { mock_model Comment }

    before do
      Article.stub(:accessible_by).and_return Article
      Article.stub(:find).with(article.id.to_s).and_return article
      article.comments.stub(:new).and_return(comment)
      mock CommentQuery
      CommentQuery.stub_chain(:new, :list).and_return Comment

      article.should_receive(:add_hit!)
      get :show, id: article
    end

    it { should respond_with :success }
    it { should render_template :show }
    it { should assign_to(:article).with article }
    it { should assign_to(:comment).with_kind_of Comment }
    it { should assign_to(:comments).with article.comments }
  end

  describe "GET #new" do
    let(:article) { mock_model Article }

    it 'creates article instance' do
      Article.should_receive(:new).and_return article
      get :new
    end

    it do
      get :new
      should respond_with :success
    end

    it do
      get :new
      should render_template :new
    end
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
    let(:article) { mock_model Article }
    before do
      Article.stub(:accessible_by).and_return Article
      Article.stub(:find).with(article.id.to_s).and_return article
      get :edit, id: article
    end
    it { should respond_with :success }
    it { should render_template :edit }
    it { should assign_to(:article).with article }
  end

  describe "PUT #update" do
    let(:article) { create :article }
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
    let(:article) { mock_model Article }

    before do
      DateTime.stub(:current).and_return DateTime.current
      Article.stub(:accessible_by).and_return Article
      Article.stub(:find).with(article.id.to_s).and_return article
    end

    it do
      article.stub(:mark_as_deleted_by)
      delete :destroy, id: article
      should redirect_to articles_path
    end

    it "receives mark_as_deleted_by call", skip_destroy: true do
      article.should_receive(:mark_as_deleted_by)
      delete :destroy, id: article
    end
  end

  describe "PUT #restore" do
    let(:article) { mock_model Article, deleted: true }

    before do
      Article.stub(:accessible_by).and_return Article
      Article.stub(:find).with(article.id.to_s).and_return article
    end

    it 'restores the Article' do
      article.should_receive(:restore)
      put :restore, id: article.id
    end

    it 'redirects to Article index' do
      article.stub(:restore)
      put :restore, id: article.id
      should redirect_to articles_path
    end
  end
end
