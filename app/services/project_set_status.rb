class ProjectSetStatus
  def initialize(project)
    @project = project
  end

  def not_interested_and_save
    return false unless interestable?

    @project.not_interested!
    return unless @project.save
    ProjectStatusMailer.delay.consultant_not_interested(@project.id)
    true
  end

  def offer_and_save
    return false unless hireable?

    if @project.respond_to? :offered!
      @project.offered!
    else
      @project.model.offered!
    end

    return unless @project.save
    ProjectStatusMailer.delay.consultant_new_offer(@project.id)
    true
  end

  def not_pursuing_and_save
    return false if not_pursuable?

    @project.not_pursuing!
    return unless @project.save
    ProjectStatusMailer.delay.company_not_pursuing(@project.id)
    true
  end

  def agree_to_terms_and_save
    return false unless @project.offered?

    @project.agreed_to_terms!
    return unless @project.save
    ProjectStatusMailer.delay.gces_agreed_to_terms(@project.id)
    ProjectStatusMailer.delay.consultant_agreed_to_terms(@project.id)
    ProjectStatusMailer.delay.company_agreed_to_terms(@project.id)
    true
  end

  def under_revision_and_save
    return false unless @project.offered?

    @project.under_revision!
    return unless @project.save
    ProjectStatusMailer.delay.consultant_rejected_terms(@project.id)
    true
  end

  def interestable?
    @project.offered?
  end

  def hireable?
    if @project.respond_to? :under_revision?
      @project.under_revision?
    else
      @project.model.under_revision?
    end
  end

  def not_pursuable?
    @project.not_pursuing? || @project.not_interested? || @project.agreed_to_terms?
  end
end
