class ContactRequestSetStatus
  def initialize(contact_request)
    @contact_request = contact_request
  end

  def interested_and_save
    return false unless @contact_request.pending?

    @contact_request.interested!
    @contact_request.save
  end

  def not_interested_and_save
    return false unless @contact_request.pending? || @contact_request.interested? ||
                        @contact_request.hired?

    @contact_request.not_interested!
    @contact_request.save
  end

  def hire_and_save
    return false unless @contact_request.interested? || @contact_request.rejected_terms?

    @contact_request.hired!
    @contact_request.save
  end

  def not_pursuing_and_save
    return false unless @contact_request.interested?

    @contact_request.not_pursuing!
    @contact_request.save
  end

  def agree_to_terms_and_save
    return false unless @contact_request.hired?

    @contact_request.agreed_to_terms!
    @contact_request.save
  end

  def reject_terms_and_save
    return false unless @contact_request.hired?

    @contact_request.rejected_terms!
    @contact_request.save
  end
end
