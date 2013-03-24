class PagesController < ApplicationController
  authorize_resource

  respond_to :html

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
    flash[:notice] = t(:created_successfully) if @page.save
    respond_with @page, location: pages_path
  end

  def edit
  end

  def update
    if @page.update_attributes params[:page]
      flash[:notice] = t(:updated_successfully)
    end
    respond_with @page, location: pages_path
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
