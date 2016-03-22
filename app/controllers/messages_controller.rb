class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    conversations = Conversation.between(current_user.id, params[:recipient_id])
    @conversation = conversations.first || Conversation.create(recipient_id: params[:recipient_id], sender_id: current_user.id)
    @message = Message.new(body: params[:body], conversation: @conversation, user: current_user) 
    if @message.save
      flash[:success] = "Message sent successfully"
    else
      flash[:danger] = "Failed to send message"
    end
    redirect_to conversations_path
  end
  
end
