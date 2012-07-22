source 'https://rubygems.org'

gem 'rails', '~> 3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2', "< 3.0"
# gem 'sqlite3'
gem 'tiny_tds'
gem 'activerecord-sqlserver-adapter', '~> 3.2.0'

gem 'haml', '~> 3.1.6'
gem 'meta-tags', '~> 1.2.6', :require => 'meta_tags'
gem 'kaminari' , "~> 0.13.0"
gem 'devise'
gem 'acts_as_commentable'




# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'passenger'
  gem 'exception_notification'
end

group :development do
  gem 'capistrano'
  gem 'pry'
  gem 'passenger'
end

group :test, :development do
  gem 'rspec-rails', '~> 2.11.0'
  gem 'factory_girl_rails'
  gem 'capybara'
end

gem 'jquery-rails'
