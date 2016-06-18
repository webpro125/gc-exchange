class ProjectAgreementMailer < ActionMailer::Base
  # include Roadie::Rails::Automatic

  def created_draft(project)
    @user = project.consultant
    @project = project
    mail(subject: 'Created Draft', to: user.email)
  end

  def resubmitted_draft project
    @user = project.consultant
    @project = project
    mail(subject: 'Resubmitted Draft', to: user.email)
  end
  def consultant_reviewed_draft project_agreement, user
    @project_agreement = project_agreement
    @sa_user = project_agreement.project.user
    @user = user
    mail(subject: 'Consultant Reviewed Draft', to: @sa_user.email)
  end

  def ra_reviewed_draft agreement, user
    @agreement = agreement
    @sa_user = agreement.project.user
    @ra_user = user
    mail(subject: 'Requisition Authority User Reviewed Draft', to: @sa_user.email)
  end
end
