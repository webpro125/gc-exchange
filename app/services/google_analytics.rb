require 'google/api_client'

class GoogleAnalytics
  API_VERSION = 'v3'
  CACHED_API_FILE = File.join(Rails.root, 'config', "analytics-#{API_VERSION}.cache")
  SERVICE_ACCOUNT_EMAIL = Rails.application.secrets.ga_api.service_account_email
  KEY_FILE = Rails.application.secrets.ga_api.key_file
  KEY_SECRET = Rails.application.secrets.ga_api.key_secret
  PROFILE_ID = Rails.application.secrets.ga_api.profile_id
  APP_NAME = Rails.application.secrets.app_name
  APP_VERSION = Rails.application.secrets.app_version

  def initialize(from, to)
    @from = from
    @to = to
    @client = Google::APIClient.new(
      application_name: APP_NAME,
      application_version: APP_VERSION
    )
    key = Google::APIClient::KeyUtils.load_from_pkcs12(KEY_FILE, KEY_SECRET)
    @client.authorization = Signet::OAuth2::Client.new(
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      audience: 'https://accounts.google.com/o/oauth2/token',
      scope: 'https://www.googleapis.com/auth/analytics.readonly',
      issuer: SERVICE_ACCOUNT_EMAIL,
      signing_key: key
    )
    @client.authorization.fetch_access_token!

    if File.exists? CACHED_API_FILE
      File.open(CACHED_API_FILE) do |file|
        @analytics = Marshal.load(file)
      end
    else
      @analytics = @client.discovered_api('analytics', API_VERSION)
      File.open(CACHED_API_FILE, 'w') do |file|
        Marshal.dump(@analytics, file)
      end
    end
  end

  def visits
    data = @client.execute(
      api_method: @analytics.data.ga.get,
      parameters: {
        'ids' => "ga:#{PROFILE_ID}",
        'start-date' => @from.strftime('%Y-%m-%d'),
        'end-date' => @to.strftime('%Y-%m-%d'),
        'dimensions' => 'ga:sessionCount',
        'metrics' => 'ga:users,ga:sessions',
        'sort' => '-ga:sessions'
      }
    )
  end
end