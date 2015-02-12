class ContactRequestSetStatus
  def initialize(contact_request)
    @contact_request = contact_request
  end

  def approve_and_save
    return false unless @contact_request.pending?

    @contact_request.approved!
    @contact_request.save
  end

  def reject_and_save
    @contact_request.rejected!
    @contact_request.save
  end

  def hire_and_save
    return false unless @contact_request.approved?

    @contact_request.hired!
    @contact_request.save
  end

  def fire_and_save
    return false unless @contact_request.approved?

    @contact_request.fired!
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
