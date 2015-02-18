class ProjectSetStatus
  def initialize(project)
    @project = project
  end

  def not_interested_and_save
    return false unless interestable?

    @project.not_interested!
    return unless @project.save
    ContactStatusMailer.delay.consultant_not_interested(@project.id)
    true
  end

  def hire_and_save
    return false unless hireable?

    @project.hired!
    @project.save
  end

  def not_pursuing_and_save
    return false if not_pursuable?

    @project.not_pursuing!
    return unless @project.save
    ContactStatusMailer.delay.company_not_pursuing(@project.id)
    true
  end

  def agree_to_terms_and_save
    return false unless @project.hired?

    @project.agreed_to_terms!
    return unless @project.save
    ContactStatusMailer.delay.consultant_agreed_to_terms(@project.id)
    true
  end

  def reject_terms_and_save
    return false unless @project.hired?

    @project.rejected_terms!
    return unless  @project.save
    ContactStatusMailer.delay.consultant_rejected_terms(@project.id)
    true
  end

  def interestable?
    @project.hired?
  end

  def hireable?
    @project.rejected_terms?
  end

  def not_pursuable?
    @project.not_pursuing? || @project.not_interested? || @project.agreed_to_terms?
  end
end
