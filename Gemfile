source 'https://rubygems.org'

gem 'rails', '~> 3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem "pg"

gem 'jquery-rails'

gem 'tiny_tds', "~> 0.5.1"
gem 'activerecord-sqlserver-adapter', '~> 3.2.10'

gem 'haml'
gem 'meta-tags', '~> 1.2.6', :require => 'meta_tags'
gem 'kaminari' , "~> 0.13.0"
gem 'devise', "~> 2.2.3"
gem 'acts_as_commentable', "~> 3.0.1"
gem "acts-as-taggable-on", "~> 2.3.3"

gem 'anjlab-bootstrap-rails', ">= 2.3", :require => 'bootstrap-rails'
gem 'has_scope', "~> 0.5.1"
gem "squeel", "~> 1.0.17"
gem "bitmask_attributes", "~> 0.4.0"
gem "russian", "~> 0.6.0"
gem "cancan", "~> 1.6.8"
gem "simple_form", "~> 2.1.0"
gem "client_side_validations", "~> 3.2.1"

gem "carrierwave", "~> 0.8.0"
gem "mini_magick", "~> 3.5.0"
gem "ckeditor", "~> 4.0.2"
gem "twitter_cldr", "~> 2.2.0"
gem "battlenet_info", "0.2.1"

group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'therubyracer'
  gem 'uglifier',     '>= 1.0.3'
end

group :production do
  gem 'exception_notification'
end

group :development do
  gem "capistrano", :require => false
  gem 'capistrano-recipes', :require => false
  gem 'capistrano_colors', :require => false
  gem 'capistrano-unicorn', '~> 0.1.6', require: false
  gem "rails_best_practices"
  gem "thin"
  gem "zeus"
end

group :test, :development do
  gem 'rspec-rails',        '~> 2.11.0'
  gem 'factory_girl_rails', '~> 3.5.0'
  gem 'pry-rails'
end

group :test do
  gem "ffaker",           "~> 1.15.0"
  gem 'capybara',         "~> 1.1.2"
  gem "database_cleaner", "~> 0.8.0"
  gem "launchy",          "~> 2.1.0"
  gem "shoulda",          "~> 3.1.1"
  gem "email_spec",       "~> 1.2.1"
end

gem "unicorn",     "~> 4.6.0", group: [:development, :production]
