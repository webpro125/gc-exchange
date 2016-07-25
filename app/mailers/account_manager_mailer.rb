class AccountManagerMailer < ActionMailer::Base
  # include Roadie::Rails::Automatic

  def assigned_role(unit_role, accept_token)
    @unit_role = unit_role
    @accept_token = accept_token
    mail(subject: 'You are assigned', to: @unit_role.user.email)
  end

  def created_business_role_name(business_unit_name, user)
    @business_unit_name = business_unit_name
    @user = user
    mail(subject: 'Created Business unit name', to: @user.email)
  end
end
