class CompanyMailer < ActionMailer::Base
  def company_registration_request(sales_lead)
    @sales_lead = sales_lead
    mail(subject: 'New Company Registration Request')
  end
end
