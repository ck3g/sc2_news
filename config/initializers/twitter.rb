Twitter.configure do |config|
  config.consumer_key = SiteConfig.instance.consumer_key
  config.consumer_secret = SiteConfig.instance.consumer_secret
  config.oauth_token = SiteConfig.instance.oauth_token
  config.oauth_token_secret = SiteConfig.instance.oauth_token_secret
end
