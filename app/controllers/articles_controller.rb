class ArticlesController < ApplicationController
  has_scope :by_tag

  def index
    @articles = apply_scopes(Article.includes(:user)).order("created_at DESC").page(params[:page])
  end

end
