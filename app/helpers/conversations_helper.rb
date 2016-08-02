module ConversationsHelper

  def receiver_side_conversation? conversation
    conversation.originator.id == current_user.id
  end

  def conversation_menu_class conversation, active_id
    class_name = ''
    class_name += active_id == conversation.id ? 'is-active ' : ''
    class_name += conversation.is_unread?(pundit_user) ? '' : 'is-read'
  end
end
