class CompanyMailer < ActionMailer::Base
  default from: ENV['COMPANY_FROM_EMAIL']

  def company_registration_request(lead_id)
    @sales_lead = SalesLead.find(lead_id)
    mail(to: [ENV['GCE_MAIL_TO_LIST']], subject: 'New Company Registration Request', from: @sales_lead.email)
  end
end
