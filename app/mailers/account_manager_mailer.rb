class AccountManagerMailer < ActionMailer::Base
  # include Roadie::Rails::Automatic

  def assigned_role(user, generated_password, accept_token)
    @user = user
    @password = generated_password
    @accept_token = accept_token
    mail(subject: 'New Company Registration Request', to: user.email)
  end

  def created_business_role_name(account_manager, user)
    @account_manager = account_manager
    @user = user
    mail(subject: 'Created Business unit name', to: @user.email)
  end
end
