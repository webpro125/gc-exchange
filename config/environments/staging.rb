require File.expand_path('../production', __FILE__)

Rails.application.configure do
  config.consider_all_requests_local = true

  config.action_mailer.smtp_settings = { address: 'email-smtp.us-east-1.amazonaws.com',
                                         port: 25,
                                         authentication: :login,
                                         domain: 'staging.globalconsultantexchange.com',
                                         user_name: Rails.application.secrets.email_username,
                                         password: Rails.application.secrets.email_password
  }
  config.action_mailer.default_url_options = { host: 'staging.globalconsultantexchange.com' }
  # TODO: need to write an interceptor instead.
end
