class CommentsController < ApplicationController
  load_and_authorize_resource

  respond_to :js

  before_filter :find_article
  before_filter :find_comment, only: [:update, :destroy]

  def create
    @comment = prepare_comment params[:comment]
    if @comment.save
      @new_comment = @article.comments.new
    end
  end

  def update
    @comment.update_attributes params[:comment]
  end

  def destroy
    @comment.destroy
  end

  private
  def find_article
    @article = Article.find params[:article_id]
  end

  def find_comment
    @comment = @article.comments.find params[:id]
  end

  def prepare_comment(attributes)
    comment = @article.comments.new attributes
    comment.user = current_user
    comment.ip_address = request.remote_ip

    comment
  end
end
