class ArticlesController < ApplicationController


  def index
    @articles = Article.recent.limit(20)
    respond_with @articles
  end

  def tag

    # need a rescue here from not_found. Maybe not here, but in app_controller
    @tag = params[:tag]
    @articles = Article.by_tag(@tag)
    respond_with @articles
  end
end
