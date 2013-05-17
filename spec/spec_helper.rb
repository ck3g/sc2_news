require 'rubygems'

ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false

  config.include FactoryGirl::Syntax::Methods
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include Devise::TestHelpers, type: :controller
  config.extend LoginMacros, type: :controller
  config.include FeatureLoginMacros

  config.before(:each) do
    GC.disable
  end

  config.after(:each) do
    GC.enable
  end
end

