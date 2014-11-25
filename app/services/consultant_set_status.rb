class ConsultantSetStatus
  def initialize(consultant)
    @consultant = consultant
  end

  def approve_and_save
    return false unless approvable?

    @consultant.approved_status = ApprovedStatus.approved
    @consultant.save
  end

  def reject_and_save
    return false unless rejectable?

    @consultant.approved_status = ApprovedStatus.rejected
    @consultant.save
  end

  def pending_approval_and_save
    return false unless pending_approvable?

    @consultant.approved_status = ApprovedStatus.pending_approval
    @consultant.save
  end

  def approvable?
    @consultant.pending_approval? || @consultant.rejected?
  end

  def rejectable?
    @consultant.pending_approval? || @consultant.approved?
  end

  def pending_approvable?
    @consultant.in_progress? &&
      @consultant.wizard_step == Wicked::FINISH_STEP &&
      @consultant.project_histories.size > 0
  end
end
