require 'spec_helper'

describe CommentsController do
  login_admin

  let(:article) { create :article }
  let(:comment) { create :comment, commentable: article }

  describe "POST #create" do
    before do
      ActionDispatch::Request.any_instance.stub(:remote_ip).and_return "192.168.0.1"
    end
    context "when valid attributes" do
      before do
        xhr :post, :create, article_id: article, comment: attributes_for(:comment)
      end
      it { expect(assigns[:article]).to eq article }
      it { expect(assigns[:comment]).to be_kind_of Comment }
      it { expect(assigns[:new_comment]).to be_kind_of Comment }
      it { should render_template :create }
      it "creates the comment" do
        expect {
          xhr :post, :create, article_id: article, comment: attributes_for(:comment)
        }.to change(article.comments, :count).by(1)
      end
      it "saves client's ip address" do
        expect(Comment.last.ip_address).to eq "192.168.0.1"
      end
    end

    context "when invalid attributes" do
      before do
        xhr :post, :create, article_id: article, comment: attributes_for(:invalid_comment)
      end
      it { expect(assigns[:article]).to eq article }
      it { expect(assigns[:comment]).to be_kind_of Comment }
      it "don't changes the comment" do
        expect {
          xhr :post, :create, article_id: article, comment: attributes_for(:invalid_comment)
          article.reload
        }.to_not change(Comment, :count)
      end
    end
  end

  describe "PUT #update" do
    describe "when valid attributes" do
      before do
        xhr :put, :update, article_id: article, id: comment, comment: attributes_for(:comment)
      end
      it { expect(assigns[:article]).to eq article }
      it { expect(assigns[:comment]).to eq comment }
      it { should render_template :update }
      it "changes the comment body" do
        expect {
          xhr :put, :update, article_id: article, id: comment, comment: attributes_for(:comment, comment: "New comment message")
          comment.reload
        }.to change(comment, :comment).to("New comment message")
      end
    end

    describe "when invalid attributes" do
      before do
        xhr :put, :update, article_id: article, id: comment, comment: attributes_for(:invalid_comment)
      end
      it { expect(assigns[:article]).to eq article }
      it { expect(assigns[:comment]).to eq comment }
      it "don't update the title" do
        expect {
          xhr :put, :update, article_id: article, id: comment, comment: attributes_for(:invalid_comment, title: "New Title")
          comment.reload
        }.to_not change(comment, :title).to("New Title")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:article) { mock_model Article, id: 73 }
    let(:comment) { mock_model Comment, id: 42 }

    before do
      Article.stub(:find).with(article.id.to_s).and_return article
      article.stub(:comments).and_return Comment
      Comment.stub(:find).with(comment.id.to_s).and_return comment
    end

    it 'calls destroy comment' do
      comment.should_receive(:destroy)
      xhr :delete, :destroy, article_id: article, id: comment
    end

    it 'renders destroy view' do
      comment.stub(:destroy)
      xhr :delete, :destroy, article_id: article, id: comment
      should render_template :destroy
    end
  end
end
