class CompanyMailer < ActionMailer::Base
  def company_registration_request(sales_lead)
    @sales_lead = sales_lead
    mail(to: ['test@test.com'],
         subject: 'New Company Registration Request', from: @sales_lead.email)
  end
end
