Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets  = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  Geocoder.configure(lookup: :test)
  Geocoder::Lookup::Test::INVALID_ADDRESS = 'oaiwjevoiajwefaw AZ, 99999'
  Geocoder::Lookup::Test.add_stub(Geocoder::Lookup::Test::INVALID_ADDRESS, [{}])
  Geocoder::Lookup::Test.set_default_stub(
    [
      {
        'latitude'     => 40.7143528,
        'longitude'    => -74.0059731,
        'address'      => '1619 3rd Ave New York, NY 10128',
        'state'        => 'New York',
        'state_code'   => 'NY',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ]
  )
end
