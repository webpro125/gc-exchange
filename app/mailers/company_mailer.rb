class CompanyMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  def company_registration_request(sales_lead)
    @sales_lead = sales_lead
    mail(subject: 'New Company Registration Request')
  end

  def invite_account_manager(company)
    @company = company
    mail(subject: 'Invite Account Manager', to:company.invite_user.email) do |format|
      format.html {
        render layout: 'company_mailer'
      }
      format.text
    end
  end
end
