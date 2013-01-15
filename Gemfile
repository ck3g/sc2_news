source 'https://rubygems.org'

gem 'rails', '~> 3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2', "< 3.0"
# gem 'sqlite3'

gem 'jquery-rails'
gem 'tiny_tds', "~> 0.5.1"
gem 'activerecord-sqlserver-adapter', '~> 3.2.0'

gem 'haml', '~> 3.1.6'
gem 'meta-tags', '~> 1.2.6', :require => 'meta_tags'
gem 'kaminari' , "~> 0.13.0"
gem 'devise', "~> 2.1.2"
gem 'acts_as_commentable', "~> 3.0.1"

gem 'anjlab-bootstrap-rails', ">= 2.2", :require => 'bootstrap-rails'
gem 'has_scope', "~> 0.5.1"
gem "squeel", "~> 1.0.7"

gem 'jquery-rails'



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
  gem 'pry-rails'
  gem "rails_best_practices"
  gem "thin"
end

group :test, :development do
  gem 'rspec-rails',        '~> 2.11.0'
  gem 'factory_girl_rails', '~> 3.5.0'
  gem "guard-rspec",        "~> 1.2.0"
end

group :test do
  gem "faker",            "~> 1.0.1"
  gem 'capybara',         "~> 1.1.2"
  gem "database_cleaner", "~> 0.8.0"
  gem "launchy",          "~> 2.1.0"
  gem 'spork',            '>= 0.9.0.rc9'
  gem 'guard-spork',      '~> 1.1.0'
  gem "shoulda",          "~> 3.1.1"
  gem "email_spec",       "~> 1.2.1"

  gem 'rb-fsevent',       '>= 0.4.3', :require => false
  gem 'growl',            '~> 1.0.3', :require => false
  gem 'rb-inotify',       '>= 0.8.6', :require => false
  gem 'libnotify',        '~> 0.5.7', :require => false
end
