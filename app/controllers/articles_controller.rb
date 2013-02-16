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

  def show

  end

  private
  def find_article
    @article = Article.find params[:id]
  end
end
