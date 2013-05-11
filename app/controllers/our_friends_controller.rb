class OurFriendsController < ApplicationController
  authorize_resource

  before_filter :find_friend, only: [:edit, :update, :destroy]

  def index
    @friends = OurFriend.order('created_at DESC').page(params[:page])
  end

  def new
    @friend = OurFriend.new
  end

  def create
    @friend = OurFriend.new params[:our_friend]
    flash.notice = t(:created_successfully) if @friend.save
    respond_with @friend, location: our_friends_path
  end

  def edit
  end

  def update
    if @friend.update_attributes params[:our_friend]
      flash.notice = t(:updated_successfully)
    end
    respond_with @friend, location: our_friends_path
  end

  def destroy
    @friend.destroy
    redirect_to our_friends_path
  end

  private
  def find_friend
    @friend = OurFriend.find params[:id]
  end
end
