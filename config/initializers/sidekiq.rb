Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redistogo:efedf4614c6c9b98667075aea4bbaa4e@hoki.redistogo.com:9079/'}
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redistogo:efedf4614c6c9b98667075aea4bbaa4e@hoki.redistogo.com:9079/'}
end
