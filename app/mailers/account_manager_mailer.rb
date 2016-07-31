class AccountManagerMailer < ActionMailer::Base
  # include Roadie::Rails::Automatic

  def assigned_role(unit_role, accept_token)
    @unit_role = unit_role
    @accept_token = accept_token
    @account_manager = @unit_role.account_manager
    subject = @account_manager.user.full_name + ' has invited you to join his Business Unit on Global Consultant Exchange'
    mail(subject: subject, to: @unit_role.user.email)
  end

  def created_business_role_name(business_unit_name, user)
    @business_unit_name = business_unit_name
    @user = user
    mail(subject: 'Created Business unit name', to: @user.email)
  end
end
