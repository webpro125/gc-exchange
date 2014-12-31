loaded_file = ERB.new(File.read("#{Rails.root}/config/fog.yml")).result
fog_config = YAML.load(loaded_file)[Rails.env].deep_symbolize_keys

CarrierWave.configure do |config|
  config.enable_processing = true
  config.storage = fog_config[:storage]
  config.fog_credentials = fog_config[:fog_credentials]
  config.fog_directory  = fog_config[:fog_directory]
end
