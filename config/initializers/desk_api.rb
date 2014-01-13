DeskApi.configure do |config|
  config.subdomain = ENV['DESK_SUBDOMAIN']
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.token = ENV['OAUTH_TOKEN']
  config.token_secret = ENV['OAUTH_TOKEN_SECRET']
end
