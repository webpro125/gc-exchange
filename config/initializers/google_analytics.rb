ga_config_file = ERB.new(File.read("#{Rails.root}/config/ga_api.yml")).result
ga_config = YAML.load(ga_config_file)[Rails.env]

if ga_config.present?
  GA_API_CONFIG = ga_config.deep_symbolize_keys
  GA_API_CLIENT = GoogleAnalyticsApi.new
end