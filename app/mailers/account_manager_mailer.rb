class AccountManagerMailer < ActionMailer::Base
  # include Roadie::Rails::Automatic

  def assigned_role(user, generated_password, accept_token)
    @user = user
    @password = generated_password
    @accept_token = accept_token
    mail(subject: 'New Company Registration Request', to: user.email)
  end

end
