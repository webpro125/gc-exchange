module ConversationsHelper

  def receiver_side_conversation? conversation
    conversation.originator.id == current_user.id
  end
end
