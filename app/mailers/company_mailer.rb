class CompanyMailer < ActionMailer::Base
  # include Roadie::Rails::Automatic

  def company_registration_request(sales_lead)
    @sales_lead = sales_lead
    mail(subject: 'New Company Registration Request')
  end

  def invite_account_manager(account_manager)
    @account_manager = account_manager

    # mail(subject: 'Invite Account Manager', to:account_manager.email) do |format|
    #   format.html {
    #     render layout: 'company_mailer'
    #   }
    #   format.text
    # end
    mail(subject: 'Invitation for Account Manager role in Global Consultant Exchange', to:account_manager.email)
  end

  def company_created(company)
    @company = company
    mail(subject: 'Company Account is created', to:company.owner.email)
  end

  def company_requested(requested_company, admin)
    @requested_company = requested_company
    mail(subject: 'Company Creation is Requested', to:admin.email)
  end
end
