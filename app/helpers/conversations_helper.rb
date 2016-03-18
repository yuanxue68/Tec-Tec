module ConversationsHelper

  def other_participant(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end

end
