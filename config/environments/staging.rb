require File.expand_path('../production', __FILE__)

Rails.application.configure do
  config.consider_all_requests_local = true

  # TODO: need to write an interceptor instead.
end
