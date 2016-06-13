class AccountManagerMailer < ActionMailer::Base
  # include Roadie::Rails::Automatic

  def assigned_role(user, generated_password)
    @user = user
    @password = generated_password
    mail(subject: 'New Company Registration Request', to: user.email)
  end

end
