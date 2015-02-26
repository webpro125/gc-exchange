class ProjectStatusMailer < ActionMailer::Base
  def consultant_not_interested(project)
    mailer_objects(project)
    mail(subject: 'Consultant is not interested', to: @user.email)
  end

  def company_not_pursuing(project)
    mailer_objects(project)
    mail(subject: 'Company is not pursuing', to: @consultant.email)
  end

  def consultant_agreed_to_terms(project)
    mailer_objects(project)
    mail(subject: 'Engagement Acceptance Notice', to: @consultant.email)
  end

  def company_agreed_to_terms(project)
    mailer_objects(project)
    mail(subject: 'Engagement Acceptance Notice', to: @user.email)
  end

  def gces_agreed_to_terms(project)
    mailer_objects(project)
    mail(subject: 'Engagement Acceptance Notice', to: @user.email)
  end

  def consultant_rejected_terms(project)
    mailer_objects(project)
    mail(subject: 'Consultant rejected terms', to: @user.email)
  end

  def consultant_hired(project)
    mailer_objects(project)
    mail(subject: 'Consultant hired', to: @consultant.email)
  end

  def mailer_objects(project)
    @project = Project.find(project)
    @consultant = Consultant.find(@project.consultant_id)
    @user = User.find(@project.user_id)
  end
end
