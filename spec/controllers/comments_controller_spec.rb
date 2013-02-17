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
      it { should assign_to(:article).with article }
      it { should assign_to(:comment).with_kind_of Comment }
      it { should assign_to(:new_comment).with_kind_of Comment }
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
      it { should assign_to(:article).with article }
      it { should assign_to(:comment).with_kind_of Comment }
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
      it { should assign_to(:article).with article }
      it { should assign_to(:comment).with comment }
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
      it { should assign_to(:article).with article }
      it { should assign_to(:comment).with comment }
      it "don't update the title" do
        expect {
          xhr :put, :update, article_id: article, id: comment, comment: attributes_for(:invalid_comment, title: "New Title")
          comment.reload
        }.to_not change(comment, :title).to("New Title")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      comment
      unless example.metadata[:skip_destroy]
        xhr :delete, :destroy, article_id: article, id: comment
      end
    end
    it { should render_template :destroy }
    it { should assign_to(:article).with article }
    it { should assign_to(:comment).with comment }
    it "deletes the comment", skip_destroy: true do
      expect {
        xhr :delete, :destroy, article_id: article, id: comment
      }.to change(Comment, :count).by(-1)
    end
  end
end
