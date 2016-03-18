class ConversationsController < ApplicationController
  before_action :authenticate_user!

  # :( 
  def index
    @conversations = Conversation.latest_conversations(current_user).includes(:sender, :recipient).paginate(page: params[:conversation_page]).per_page(3)
    if current_user.is_part_of_convo(params[:conversation_id])
      @messages = Conversation.find(params[:conversation_id]).messages.paginate(page: params[:message_page]).per_page(2)
    end

  end

end
