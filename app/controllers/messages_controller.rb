class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversations = Conversation.between(current_user.id, params[:recipient_id])
    unless @conversations.present?  
      @converstaions = Conversation.create!(recipient_id: params[:recipient_id], sender_id: current_user.id)
    end
    @message = Message.new(body: params[:body], conversation: @conversations.first, user: current_user) 
    if @message.save
      flash[:success] = "Message sent successfully"
    else
      flash[:danger] = "Failed to send message"
    end
    redirect_to conversations_path
  end
  
end
