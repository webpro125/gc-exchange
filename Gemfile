source 'https://rubygems.org'

gem 'rails', '4.1.7'
gem 'pg', '~> 0.17'

gem 'sass-rails', '~> 4.0.4'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails', '~> 3.1.0'
gem 'foundation-rails', '~> 5.3.1'
gem 'simple_form', '~> 3.0'
gem 'devise', '~> 3.2'
gem 'paperclip', '~> 4.2'
gem 'geocoder', '~> 1.2.2'
gem 'pundit', '~> 0.3.0'
gem 'fog', '~> 1.3'
gem 'newrelic_rpm', '~> 3.9'
gem 'kaminari', '~> 0.16.1'
gem 'elasticsearch-model', '~> 0.1.5'
gem 'elasticsearch-rails', '~> 0.1.5'
gem 'pry-rails'
gem 'sidekiq', '~> 3.2.5'
gem 'sidekiq-unique-jobs', '~> 3.0.2'
gem 'sinatra', '~> 1.4.5'
gem 'reform', '~> 1.2.1'
gem 'file_validators', '~> 1.2.0'
gem 'virtus', '~> 1.0.3'
gem 'wicked', '~> 1.1.0'
gem 'select2-rails', '~> 3.5'
gem 'jquery-ui-rails', '~> 5.0'
gem 'migration_data', '~> 0.0.4'
gem 'foundation-datetimepicker-rails', '~> 0.1.3'
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 4.0.0'
gem 'foundation-icons-sass-rails', '~> 3.0.0'
gem 'google-webfonts-rails', '~> 0.0.4'
gem 'cocoon', '~> 1.2.6'
gem 'mailboxer', '~> 0.12.5'
gem 'jquery-datatables-rails', '~> 3.2.0'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'exception_notification', '4.1.1'
gem 'google-analytics-rails', '~> 0.0.6'
gem 'coffee-rails'
gem 'momentjs-rails'

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

group :development do
  gem 'better_errors', '~> 2.0.0'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'dotenv-rails'
  gem 'thin'
end

group :development, :test do
  # Debugger
  gem 'byebug', '~> 3.5', require: false
  gem 'spring', '~> 1.1.3'

  # Guard
  gem 'spring-commands-rspec', '~> 1.0.2', require: false
  gem 'rb-readline', '~> 0.5.1'
  gem 'guard-bundler', '~> 2.0.0', require: false
  gem 'guard-migrate', '~> 1.2.0', require: false
  gem 'guard-rspec', '~> 4.3', require: false
  gem 'guard-brakeman', '~> 0.8.1', require: false
  gem 'guard-rubocop', '~> 1.2.0', require: false

  gem 'rubocop', '~> 0.27', require: false
  gem 'brakeman', '~> 2.6.2', require: false

  gem 'rspec-rails', '~> 2.99'
  gem 'rspec-activemodel-mocks', '~> 1.0.1'

  gem 'capybara', '~> 2.4', require: false
  gem 'yarjuf'
  gem 'shoulda-matchers', '~> 2.7.0', require: false
end

group :test do
  gem 'database_cleaner', '~> 1.3.0', require: false
  gem 'factory_girl_rails', '~> 4.4'
  gem 'faker', '~> 1.4.3'
  gem 'simplecov-bamboo', '~> 0.1.0', require: false
  gem 'test_after_commit', '~> 0.4.0'
  gem 'elasticsearch-extensions', '~> 0.0.15'
  gem 'mock_redis', '~> 0.13.2'
end

group :development, :staging do
  gem 'quiet_assets', '~> 1.0'
end

group :production, :staging, :sales do
  gem 'unicorn', '~> 4.8.3'
end
