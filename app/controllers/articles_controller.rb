class ArticlesController < ApplicationController
  load_and_authorize_resource

  before_filter :find_article, only: [:show, :update, :destroy]

  has_scope :tagged_with

  def index
    relation = apply_scopes(Article.accessible_by(current_ability))
    @articles = ArticleQuery.new(relation).list.page(params[:page])
    set_meta_tags title: I18n.t(:articles)
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
      redirect_to @article, notice: t(:updated_successfully)
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  def find_article
    @article = Article.accessible_by(current_ability).find params[:id]
  end
end
