class ContactStatusMailer < ActionMailer::Base
  def consultant_not_interested(contact_request)
    mailer_objects(contact_request)
    mail(subject: 'Consultant is not interested', to: @user.email)
  end

  def company_not_pursuing(contact_request)
    mailer_objects(contact_request)
    mail(subject: 'Company is not pursuing', to: @consultant.email)
  end

  def consultant_agreed_to_terms(contact_request)
    mailer_objects(contact_request)
    mail(subject: 'Consultant agreed to terms', to: @user.email)
  end

  def consultant_rejected_terms(contact_request)
    mailer_objects(contact_request)
    mail(subject: 'Consultant rejected terms', to: @user.email)
  end

  def mailer_objects(contact_request)
    @contact_request = ContactRequest.find(contact_request)
    @consultant = Consultant.find(@contact_request.consultant_id)
    @user = User.find(@contact_request.user_id)
  end
end
