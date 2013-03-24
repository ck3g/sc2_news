class ArticlesController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  before_filter :find_article, only: [:show, :update, :destroy, :restore]

  has_scope :tagged_with

  def index
    relation = apply_scopes(Article.accessible_by(current_ability))
    @articles = ArticleQuery.new(relation).list.page(params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new params[:article]
    @article.ip_address = request.remote_ip
    if @article.save
      redirect_to @article, notice: t(:created_successfully)
    else
      render :new
    end
  end

  def show
    @comment = @article.comments.new
    @comments = @article.comments.order("created_at ASC")
  end

  def edit
  end

  def update
    if @article.update_attributes params[:article]
      flash[:notice] = t(:updated_successfully)
    end
    respond_with @article
  end

  def destroy
    @article.mark_as_deleted_by current_user
    redirect_to articles_path
  end

  def restore
    @article.restore
    redirect_to articles_path
  end

  private
  def find_article
    @article = Article.accessible_by(current_ability).find params[:id]
  end
end
