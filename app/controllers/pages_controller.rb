class PagesController < ApplicationController
  authorize_resource

  before_filter :find_page, only: [:edit, :update, :destroy]

  def index
    raise CanCan::AccessDenied unless User.admin?(current_user)
    @pages = Page.order(:title)
  end

  def show
    @page = Page.by_permalink! params[:permalink]
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new params[:page]
    if @page.save
      redirect_to pages_path, notice: t(:created_successfully)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update_attributes params[:page]
      @page.reload
      redirect_to pages_path, notice: t(:updated_successfully)
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path
  end

  private
  def find_page
    @page = Page.find params[:id]
  end
end
