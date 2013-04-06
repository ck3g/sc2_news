server "194.165.39.126", :app, :web, :db, :primary => true

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :user, "kalastiuz"
set :rake, "#{rake} --trace"
set :shared_host, "194.165.39.126"
set :application, "sc2_news"
set :deploy_to,   "/home/#{user}/apps/#{application}/"
set :branch, "master"
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
after "deploy:finalize_update", "deploy:config", "deploy:update_uploads"
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

  task :update_uploads, :roles => [:app] do
    run "ln -nfs #{deploy_to}#{shared_dir}/uploads #{release_path}/public/uploads"
    run "ln -nfs #{deploy_to}#{shared_dir}/system #{release_path}/public/system"
    run "mkdir -p #{release_path}/public/Content"
    run "ln -nfs #{deploy_to}#{shared_dir}/Gallery #{release_path}/public/Content/Gallery"
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
require 'bundler/capistrano'
require "capistrano-unicorn"

