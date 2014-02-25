source 'https://rubygems.org'

gem 'rails', '~> 3.2.17'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem "pg"

gem 'jquery-rails'

gem 'haml'
gem 'meta-tags', '~> 1.5.0', :require => 'meta_tags'
gem 'kaminari' , "~> 0.14.1"
gem 'devise', "~> 2.2.4"
gem 'acts_as_commentable', "~> 3.0.1"
gem "acts-as-taggable-on", "~> 2.3.3"

gem 'anjlab-bootstrap-rails', ">= 2.3", :require => 'bootstrap-rails'
gem "font-awesome-rails", "~> 3.1.1"
gem 'has_scope', "~> 0.5.1"
gem "squeel", "~> 1.0.18"
gem "bitmask_attributes", "~> 0.4.0"
gem "russian", "~> 0.6.0"
gem "cancan", "~> 1.6.10"
gem "simple_form", "~> 2.1.0"
gem "client_side_validations", "~> 3.2.1"

gem "carrierwave", "~> 0.8.0"
gem "mini_magick", "~> 3.5.0"
gem "ckeditor", "~> 4.0.4"
gem "twitter_cldr", "~> 2.4.0"
gem "battlenet_info", "0.2.1"
gem "newrelic_rpm"
gem "draper", "~> 1.0"
gem "sanitize", "~> 2.0.3"
gem "twitter"
gem 'sitemap_generator', '~> 3.4'
gem 'whenever', '~> 0.8.2', require: false
gem 'friendly_id', '~> 4.0.0'
gem 'state_machine'
gem 'coveralls', require: false

group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'therubyracer'
  gem 'uglifier',     '~> 2.0.1'
  gem "turbo-sprockets-rails3"
  gem "compass-rails"
end

group :production do
  gem 'exception_notification'
end

group :development do
  gem "capistrano", "~> 2.15.4", :require => false
  gem 'capistrano-recipes', :require => false
  gem 'capistrano_colors', :require => false
  gem "capistrano-puma", :require => false
  gem 'capistrano-rbenv', :require => false
  gem "rails_best_practices"
  gem "thin"
  gem "zeus"
  gem "bullet"
  gem "rubocop"
  gem 'brakeman', :require => false
end

group :test, :development do
  gem 'rspec-rails',        '~> 2.13.1'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'pry-rails'
end

group :test do
  gem "ffaker",           "~> 1.16.1"
  gem 'capybara',         "~> 2.1.0"
  gem "database_cleaner", "~> 1.0.1"
  gem "launchy",          "~> 2.1.0"
  gem "shoulda",          "~> 3.1.1"
  gem "email_spec",       "~> 1.4.0"
end

group :production do
  gem "puma"
end
