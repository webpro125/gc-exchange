class ConsultantSetStatus
  def initialize(consultant)
    @consultant = consultant
  end

  def approve_and_save
    return false unless approvable?

    @consultant.approved_status = ApprovedStatus.approved
    @consultant.date_approved = DateTime.now
    @consultant.approval_number = next_approval_number
    @consultant.save
  end

  def reject_and_save
    return false unless rejectable?

    @consultant.approved_status = ApprovedStatus.rejected
    @consultant.date_rejected = DateTime.now
    @consultant.save
  end

  def pending_approval_and_save
    return false unless pending_approvable?

    @consultant.approved_status = ApprovedStatus.pending_approval
    @consultant.date_pending_approval = DateTime.now
    @consultant.save
  end

  def on_hold_and_save
    return false unless on_hold?

    @consultant.approved_status = ApprovedStatus.on_hold
    @consultant.date_on_hold = DateTime.now
    @consultant.save
  end

  def approvable?
    @consultant.pending_approval? || @consultant.rejected? || @consultant.on_hold?
  end

  def rejectable?
    @consultant.pending_approval? || @consultant.approved? || @consultant.on_hold?
  end

  def pending_approvable?
    @consultant.in_progress? &&
      @consultant.wizard_step == Wicked::FINISH_STEP &&
      @consultant.project_histories.size > 0
  end

  def on_hold?
    @consultant.in_progress? &&
      (@consultant.background.citizen == false ||
        @consultant.background.convicted == true ||
        @consultant.background.parole == true ||
        @consultant.background.illegal_drug_use == true ||
        @consultant.background.illegal_purchase == true ||
        @consultant.background.illegal_prescription == true)
  end

  private

  def next_approval_number
    Consultant.maximum(:approval_number).to_i + 1
  end

end
