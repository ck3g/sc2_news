class ChatMessagesController  < ApplicationController
  layout false
  before_filter :authenticate_user!, :except => :index


  def index
    @messages = ChatMessage.recent
    respond_with @messages
  end

  def create
    @chat_message = ChatMessage.new(params[:chat_message])
    @chat_message.user = current_user
    if @chat_message.save
      respond_with(@chat_message, :location => root_url)
    else
      respond_with(:error, :status => 302, :location => root_url)
    end
  end

end