class CompanyMailer < ActionMailer::Base
  default from: ENV['COMPANY_FROM_EMAIL']

  def company_registration_request(company_request)
    @company_request = company_request
    mail(to: [ENV['COMPANY_REQUEST_TO_EMAILS']], subject: 'New Company Registration Request',
         from: @company_request.email)
  end
end
