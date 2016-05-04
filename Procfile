redis: redis-server
#actioncable: bundle exec puma -p 28080 -t 8:32 -w 3 --preload cable/config.ru
web: bundle exec puma -p 3000 -t 8:32 -w 3 --preload ./config.ru
sidekiq: bundle exec sidekiq
