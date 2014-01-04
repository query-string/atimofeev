load 'deploy' if respond_to?(:namespace)

require 'rvm/capistrano'
require 'bundler/capistrano'

server 'atimofeev.ru', :app, :web, :db, primary: true

set :application, 'atimofeev'
set :app_dir, "/home/#{application}"
set :deploy_to, "#{app_dir}"
set :user, application
set :use_sudo, false

set :rvm_ruby_string, '2.1.0-head'
set :rvm_type, :user

set :repository, "git@github.com:query-string/#{application}.git"
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, false
set :deploy_via, :remote_cache

after 'deploy:update_code' do
 run "cd #{release_path}; bundle exec middleman build"
 run "mv #{release_path}/build/* #{release_path}/public/"
 run "rm -r #{release_path}/build"
end

after 'deploy', 'deploy:cleanup'