server "198.211.96.190", :app, :web, :db, :primary => true

set :default_environment, {
  'NEW_RELIC_LICENSE_KEY' => ENV['NEW_RELIC_LICENSE_KEY']
}

set :user, "deploy"
set :rake, "#{rake} --trace"
set :shared_host, "198.211.96.190"
set :application, "sc2_news"
set :deploy_to,   "/home/#{user}/apps/#{application}/"
set :branch, "master"
set :puma_env, "production"
set :rails_env, "production"
set :rbenv_ruby_version, "2.1.1"

#default_run_options[:shell] = '/bin/bash'
default_run_options[:pty] = true

set :repository,  "git@github.com:ck3g/sc2_news.git"
set :scm, :git

set :deploy_via,  :export
set :keep_releases, 5

set :use_sudo, false

set :rvm_type, :user
set :normalize_asset_timestamps, false

after "deploy",                 "deploy:cleanup", "refresh_sitemaps"
after "deploy:finalize_update", "deploy:config",  "deploy:update_uploads"
after "deploy:create_symlink",  "deploy:migrate"

CONFIG_FILES = %w(database mail social)

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

after 'deploy:stop', 'puma:stop'
after 'deploy:start', 'puma:start'
after 'deploy:restart', 'puma:start'
# after 'deploy:restart', 'puma:restart'

_cset(:puma_cmd) { "#{fetch(:bundle_cmd, 'bundle')} exec puma" }
_cset(:pumactl_cmd) { "#{fetch(:bundle_cmd, 'bundle')} exec pumactl" }
_cset(:puma_state) { "#{shared_path}/sockets/puma.state" }
_cset(:puma_role) { :app }

namespace :puma do
  desc 'Start puma'
  task :start, :roles => lambda { fetch(:puma_role) }, :on_no_matching_servers => :continue do
    run "rm #{shared_path}/sockets/*"
    run "cd #{current_path} && #{fetch(:puma_cmd)} -t 2:2 -q -e #{puma_env} -b 'unix://#{shared_path}/sockets/puma.sock' -S #{fetch(:puma_state)} --control 'unix://#{shared_path}/sockets/pumactl.sock' >> #{shared_path}/log/puma-#{puma_env}.log 2>&1 &", :pty => false
  end

  desc 'Stop puma'
  task :stop, :roles => lambda { fetch(:puma_role) }, :on_no_matching_servers => :continue do
    run "cd #{current_path} && #{fetch(:pumactl_cmd)} -S #{fetch(:puma_state)} stop"
  end

  desc 'Restart puma'
  task :restart, :roles => lambda { fetch(:puma_role) }, :on_no_matching_servers => :continue do
    run "cd #{current_path} && #{fetch(:pumactl_cmd)} -S #{fetch(:puma_state)} restart"
  end
end

set :sitemaps_path, 'shared/'
task :refresh_sitemaps do
  run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake sitemap:refresh"
end

set :whenever_command, "bundle exec whenever"
require 'bundler/capistrano'
require "whenever/capistrano"
require 'capistrano_colors'
require 'capistrano-rbenv'

