require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV['SECRET_KEY_ACCESS'], ENV['SECRET_KEY_PASSWORD']]
end

Sidekiq.configure_server do |config|
  config.redis = { url: "#{ENV['REDISTOGO_URL']}:6379/5"}
end

Sidekiq.configure_client do |config|
  config.redis = { url: "#{ENV['REDISTOGO_URL']}:6379/5"}
end