server "194.165.39.126", :app, :web, :db, :primary => true

set :shared_host, "194.165.39.126"
set :application, "starcraft"
set :deploy_to,   "/home/kalastiuz/rails/#{application}/"
set :user, "devmen"
set :branch, "master"
set :rvm_ruby_string, "2.0.0@sc2_news"
set :unicorn_env, "production"
set :rails_env, "production"

#default_run_options[:shell] = '/bin/bash'
default_run_options[:pty] = true

set :repository,  "git@github.com:ck3g/sc2_news.git"
set :scm, :git

set :deploy_via,  :export
set :keep_releases, 5

set :use_sudo, false

set :rvm_type, :user
set :normalize_asset_timestamps, false

after "deploy",                 "deploy:cleanup"
after "deploy:finalize_update", "deploy:config"
after "deploy:create_symlink", "deploy:migrate"

CONFIG_FILES = %w(database)

namespace :deploy do
  task :setup_config, :roles => :app do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/system"
    run "mkdir -p #{shared_path}/uploads"
    CONFIG_FILES.each do |file|
      put File.read("config/#{file}.example.yml"), "#{shared_path}/config/#{file}.yml"
    end
    puts "Now edit the config files in #{shared_path}"
  end
  after "deploy:setup", "deploy:setup_config"

  before "deploy:cold", "deploy:install_bundler"
  task :install_bundler, :roles => :app do
    run "type -P bundle &>/dev/null || { gem install bundler --no-ri --no-rdoc; }"
  end

  task :config do
    CONFIG_FILES.each do |file|
      run "cd #{release_path}/config && ln -nfs #{shared_path}/config/#{file}.yml #{release_path}/config/#{file}.yml"
    end
  end
end

desc "Tail production log files"
task :tail_logs, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    trap ("INT") { puts "\nInterrupded"; exit 0; }
    puts
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end

require 'capistrano_colors'
require "rvm/capistrano" # Rvm bootstrap
require 'bundler/capistrano'
require "capistrano-unicorn"

