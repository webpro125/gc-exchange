loaded_file = ERB.new(File.read("#{Rails.root}/config/fog.yml")).result
fog_config = YAML.load(loaded_file)[Rails.env].deep_symbolize_keys

Paperclip::Attachment.default_options.merge! fog_config
