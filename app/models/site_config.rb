class SiteConfig
  include Singleton

  TWITTER_KEYS = [:consumer_key, :consumer_secret,
                  :oauth_token, :oauth_token_secret]

  TWITTER_KEYS.each do |meth|
    define_method meth do
      config['twitter'][meth.to_s]
    end
  end

  private
  def config
    @confif ||= YAML.load_file("#{ Rails.root }/config/social.yml")
  end
end
