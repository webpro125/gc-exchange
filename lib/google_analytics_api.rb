require 'google/api_client'

class GoogleAnalyticsApi
  API_VERSION = 'v3'
  CACHED_API_FILE = File.join(Rails.root, 'tmp', 'cache', "analytics-#{API_VERSION}.cache")
  SERVICE_ACCOUNT_EMAIL = GA_API_CONFIG[:service_account_email]
  KEY_FILE = GA_API_CONFIG[:key_file]
  KEY_SECRET = GA_API_CONFIG[:key_secret]
  PROFILE_ID = GA_API_CONFIG[:profile_id]
  APP_NAME = GA_API_CONFIG[:app_name]
  APP_VERSION = GA_API_CONFIG[:app_version]

  def initialize
    begin
      @client = Google::APIClient.new(
        application_name: APP_NAME,
        application_version: APP_VERSION
      )
      key = Google::APIClient::KeyUtils.load_from_pkcs12(Rails.root.join('config', KEY_FILE).to_path, KEY_SECRET)
      @client.authorization = Signet::OAuth2::Client.new(
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        audience: 'https://accounts.google.com/o/oauth2/token',
        scope: 'https://www.googleapis.com/auth/analytics.readonly',
        issuer: SERVICE_ACCOUNT_EMAIL,
        signing_key: key
      )
      @client.authorization.fetch_access_token!

      if File.exists? CACHED_API_FILE
        File.open(CACHED_API_FILE) { |file| @analytics = Marshal.load(file) }
      else
        @analytics = @client.discovered_api('analytics', API_VERSION)
        File.open(CACHED_API_FILE, 'w') { |file| Marshal.dump(@analytics, file) }
      end
    rescue => e
      nil
    end
  end

  def pageviews(from, to)
    @client.execute(
      api_method: @analytics.data.ga.get,
      parameters: {
        'ids' => "ga:#{PROFILE_ID}",
        'start-date' => from.strftime('%Y-%m-%d'),
        'end-date' => to.strftime('%Y-%m-%d'),
        'metrics' => 'ga:pageviews'
      }
    ).data.rows[0][0].to_i
  end

  def pages_per_session(from, to)
    @client.execute(
      api_method: @analytics.data.ga.get,
      parameters: {
        'ids' => "ga:#{PROFILE_ID}",
        'start-date' => from.strftime('%Y-%m-%d'),
        'end-date' => to.strftime('%Y-%m-%d'),
        'metrics' => 'ga:pageviewsPerSession'
      }
    ).data.rows[0][0].to_i
  end

  def avg_session_duration(from, to)
    @client.execute(
      api_method: @analytics.data.ga.get,
      parameters: {
        'ids' => "ga:#{PROFILE_ID}",
        'start-date' => from.strftime('%Y-%m-%d'),
        'end-date' => to.strftime('%Y-%m-%d'),
        'metrics' => 'ga:avgSessionDuration'
      }
    ).data.rows[0][0].to_i
  end
end