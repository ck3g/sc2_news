class ArticlesController < ApplicationController


  def index
    @articles = Article.recent.all
    respond_with @articles
  end

  def tag

    # need a rescue here from not_found. Maybe not here, but in app_controller
    @tag_title = params[:tag]
    @articles = Article.by_tag(@tag_title)
    respond_with @articles
  end
end
