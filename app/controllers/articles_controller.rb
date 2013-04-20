class ArticlesController < ApplicationController
  authorize_resource

  respond_to :html

  before_filter :find_article, only: [:show, :edit, :update, :destroy, :restore]
  before_filter :increment_views_count, only: :show

  has_scope :tagged_with

  def index
    @sticky_articles = ArticleQuery.new(Article.sticky.accessible_by(current_ability)).list
    relation = apply_scopes(Article.regular.accessible_by(current_ability))
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
    @comments = CommentQuery.new(@article.comments).list
    set_meta_tags title: @article.title,
      description: @article.description,
      keywords: @article.keywords
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
    if params[:legacy_id]
      article = Article.find_by_legacy_id(params[:legacy_id])
      redirect_to article, :status => :moved_permanently
      return
    end
    @article = Article.accessible_by(current_ability).find params[:id]
  end

  def increment_views_count
    @article.add_hit!
  end
end
