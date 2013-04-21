require 'spec_helper'

describe SiteConfig do
  let(:twitter_config) do
    YAML.load_file("#{ Rails.root }/config/social.yml")['twitter']
  end

  SiteConfig::TWITTER_KEYS.each do |key|
    describe "##{ key }" do
      it do
        expect(SiteConfig.instance.send(key)).to eq twitter_config[key.to_s]
      end
    end
  end
end
