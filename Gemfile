source 'https://rubygems.org'

gem 'rails', '~> 4.0.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem "pg"

gem 'jquery-rails'

gem 'haml'
gem 'meta-tags', '~> 1.5.0', :require => 'meta_tags'
gem 'kaminari' , "~> 0.14.1"
gem 'devise', "~> 3.2.4"
gem 'acts_as_commentable', "~> 4.0.1"
gem "acts-as-taggable-on", "~> 3.1.0"

gem 'anjlab-bootstrap-rails', "2.3.1.2", :require => 'bootstrap-rails'
gem 'bootstrap-glyphicons'
gem "font-awesome-rails", "~> 4.0.3.1"
gem 'has_scope', "~> 0.5.1"
gem "squeel", "~> 1.1.1"
gem "bitmask_attributes", "~> 1.0.0"
gem "russian", "~> 0.6.0"
gem "cancancan", "~> 1.7.1"
gem "simple_form", "~> 3.0.1"

gem "carrierwave", "~> 0.8.0"
gem "mini_magick", "~> 4.9.4"
gem "ckeditor", "~> 4.0.11"
gem "twitter_cldr", "~> 2.4.0"
gem "battlenet_info", "0.2.1"
gem "newrelic_rpm"
gem "draper", "~> 1.0"
gem "sanitize", "~> 2.0.3"
gem "twitter"
gem 'sitemap_generator', '~> 3.4'
gem 'whenever', '~> 0.9.2', require: false
gem 'friendly_id', '~> 5.0.3'
gem 'state_machine'
gem 'coveralls', require: false

gem 'sass-rails',   '~> 4.0.3'
gem 'coffee-rails', '~> 4.0.1'
gem 'therubyracer'
gem 'uglifier'
gem "compass-rails"
gem 'non-stupid-digest-assets', '~> 1.0.4'

gem 'protected_attributes'
gem 'rails-observers'
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
gem 'activerecord-deprecated_finders'

group :development do
  gem "capistrano", "~> 2.15.4", :require => false
  gem 'capistrano-recipes', :require => false
  gem 'capistrano_colors', :require => false
  gem "capistrano-unicorn", :require => false
  gem 'capistrano-rbenv', :require => false
  gem "rails_best_practices"
  gem "thin"
  gem "zeus"
  gem "bullet"
  gem "rubocop"
  gem 'brakeman', :require => false
  gem 'letter_opener'
end

group :test, :development do
  gem 'rspec-rails',        '~> 2.14.2'
  gem 'factory_girl_rails', '~> 4.4.1'
  # gem 'pry-rails'
  # gem 'pry-plus'
end

group :test do
  gem "ffaker",           "~> 1.24.0"
  gem 'capybara',         "~> 2.2.1"
  gem "database_cleaner", "~> 1.2.0"
  gem "launchy",          "~> 2.4.2"
  gem "shoulda",          "~> 3.5.0"
  gem "email_spec",       "~> 1.5.0"
end

group :production do
  gem "unicorn"
  gem 'exception_notification'
end
