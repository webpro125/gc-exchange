class CompanyMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  def company_registration_request(sales_lead)
    @sales_lead = sales_lead
    mail(subject: 'New Company Registration Request')
  end

  def invite_account_manager(account_manager, password)
    @account_manager = account_manager
    @password = password
    mail(subject: 'Invite Account Manager', to:account_manager.email) do |format|
      format.html {
        render layout: 'company_mailer'
      }
      format.text
    end
  end

  def company_created(company, password)
    @company = company
    @password = password
    mail(subject: 'Company Account is created', to:company.owner.email)
  end
end
