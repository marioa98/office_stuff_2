web: rails server -p $PORT
worker: bundle exec sidekiq -c 2 -t 25 -q default -q mailers