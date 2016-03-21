class ConversationsController < ApplicationController
  before_action :authenticate_user!

  # :( 
  def index
    current_user.read_all_messages
    @conversations = Conversation
                    .latest_conversations(current_user)
                    .includes(:sender, :recipient)
                    .paginate(page: params[:conversation_page]).per_page(3)
    if current_user.is_part_of_convo(params[:conversation_id])
      @messages = Conversation
                    .find(params[:conversation_id])
                    .messages
                    .includes(:user)
                    .order(created_at: :desc)
                    .paginate(page: params[:message_page]).per_page(4)
    elsif !@conversations.empty?
      @messages = Conversation
                    .find(@conversations.first.id)
                    .messages
                    .includes(:user)
                    .order(created_at: :desc)
                    .paginate(page: params[:message_page]).per_page(4)
    end

  end

end
