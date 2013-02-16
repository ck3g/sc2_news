class ArticlesController < ApplicationController
  load_and_authorize_resource

  before_filter :find_article, only: [:show, :update, :destroy]

  has_scope :by_tag

  def index
    @articles = apply_scopes(Article.includes(:user)).order("created_at DESC").page(params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new params[:article]
    if @article.save
      redirect_to articles_path, notice: I18n.t(:created_successfully)
    else
      render :new
    end
  end

  def show

  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  def find_article
    @article = Article.find params[:id]
  end
end
