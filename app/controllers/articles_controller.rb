class ArticlesController < ApplicationController
  load_and_authorize_resource

  has_scope :by_tag

  def index
    @articles = apply_scopes(Article.includes(:user)).order("created_at DESC").page(params[:page])
  end

  def new
    @article = Article.new
  end

end
