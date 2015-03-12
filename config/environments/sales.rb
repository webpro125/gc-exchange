require File.expand_path('../production', __FILE__)

Rails.application.configure do
  # TODO: need to write an interceptor instead.

  # Do not eager load code on boot.
  # config.eager_load = false
end
