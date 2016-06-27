class ChatMessagesController  < ApplicationController
  layout false
  authorize_resource

  def index
    @messages = ChatMessage.includes(:user).recent
    respond_with @messages
  end

  def create
    @chat_message = current_user.chat_messages.new(params[:chat_message])
    if @chat_message.save
      respond_with(@chat_message, :location => root_url)
    else
      respond_with(:error, :status => 302, :location => root_url)
    end
  end

  def destroy
    @chat_message = ChatMessage.find(params[:id])
    @chat_message.destroy
    redirect_to :back
  end
end
