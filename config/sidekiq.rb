Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/5', namespace: "student_organizer" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/5', namespace: "student_organizer" }
end
