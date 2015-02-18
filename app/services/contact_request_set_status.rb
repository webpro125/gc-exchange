class ContactRequestSetStatus
  def initialize(contact_request)
    @contact_request = contact_request
  end

  def interested_and_save
    return false unless @contact_request.pending?

    @contact_request.interested!
    consultant_reply(@contact_request.consultant_id)
    @contact_request.save
  end

  def not_interested_and_save
    return false unless interestable?

    @contact_request.not_interested!
    return unless @contact_request.save
    ContactStatusMailer.delay.consultant_not_interested(@contact_request.id)
    true
  end

  def hire_and_save
    return false unless hireable?

    @contact_request.hired!
    user_reply(@contact_request.user_id)
    @contact_request.save
  end

  def not_pursuing_and_save
    return false unless @contact_request.interested?

    @contact_request.not_pursuing!
    return unless @contact_request.save
    ContactStatusMailer.delay.company_not_pursuing(@contact_request.id)
    true
  end

  def agree_to_terms_and_save
    return false unless @contact_request.hired?

    @contact_request.agreed_to_terms!
    return unless @contact_request.save
    ContactStatusMailer.delay.consultant_agreed_to_terms(@contact_request.id)
    true
  end

  def reject_terms_and_save
    return false unless @contact_request.hired?

    @contact_request.rejected_terms!
    return unless  @contact_request.save
    ContactStatusMailer.delay.consultant_rejected_terms(@contact_request.id)
    consultant_reply(@contact_request.consultant_id)
    true
  end

  def interestable?
    @contact_request.pending? || @contact_request.interested? ||
      @contact_request.hired?
  end

  def hireable?
    @contact_request.interested? || @contact_request.rejected_terms?
  end

  def reply_to_conversation(sending_user)
    conversation = Mailboxer::Conversation.find_by_id(@contact_request.communication_id)
    sending_user.reply_to_conversation(conversation, @contact_request.message)
  end

  def consultant_reply(consultant)
    @consultant = Consultant.find(consultant)
    reply_to_conversation(@consultant)
  end

  def user_reply(user)
    @user = User.find(user)
    reply_to_conversation(@user)
  end
end
