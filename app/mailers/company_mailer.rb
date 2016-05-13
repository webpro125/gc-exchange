class CompanyMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  def company_registration_request(sales_lead)
    @sales_lead = sales_lead
    mail(subject: 'New Company Registration Request')
  end

  def invite_account_manager(account_manager, password)
    @account_manager = account_manager
    @account_manager.email_content["{company_name}"] = @account_manager.company.company_name
    @account_manager.email_content["{link}"] = "#{view_context.link_to 'Register as Account Manager',
        {:controller => 'users', :action => 'register_account_manager', :only_path => false,
         :access_token => @account_manager.access_token}}"
    @password = password
    # mail(subject: 'Invite Account Manager', to:account_manager.email) do |format|
    #   format.html {
    #     render layout: 'company_mailer'
    #   }
    #   format.text
    # end
    mail(subject: 'Invite Account Manager', to:account_manager.email)
  end

  def company_created(company, password)
    @company = company
    @password = password
    mail(subject: 'Company Account is created', to:company.owner.email)
  end

  def company_requested(requested_company, admin)
    @requested_company = requested_company
    mail(subject: 'Company Creation is Requested', to:admin.email)
  end
end
