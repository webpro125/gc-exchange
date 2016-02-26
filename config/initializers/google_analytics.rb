GA.tracker = Rails.application.secrets.ga_tracker

ga_config_file = ERB.new(File.read("#{Rails.root}/config/ga_api.yml")).result
GA_API_CONFIG = YAML.load(ga_config_file)[Rails.env].deep_symbolize_keys
if GA_API_CONFIG.present?
  GA_API_CLIENT = GoogleAnalyticsApi.new
end