Sidekiq.configure_server do |config|
  config.redis = { namespace: Rails.env }
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: Rails.env }
end
