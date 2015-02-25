Mailboxer::Conversation.class_eval do
  def other_participant(current_participant)
    if current_participant == consultant_recipient
      return user_recipient
    else
      return consultant_recipient
    end
  end

  def consultant_recipient
    self.recipients.select { |r| r.is_a? Consultant }.first
  end

  def user_recipient
    self.recipients.select { |r| r.is_a? User }.first
  end
end
