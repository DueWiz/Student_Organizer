# cable/config.ru

require ::File.expand_path('../../config/environment',  __FILE__)
Rails.application.eager_load!

ActionCable.server.config.allowed_request_origins = ["http://localhost:3000"]
run ActionCable.server
