# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'debatevid.io'
set :repo_url, 'git@github.com:DebateVidio/site.git'

# Default branch is :master
set :branch, "master"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/srv/www/debatevid.io'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('.env')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  before :deploy, :set_env do
    on roles(:app, :web) do
      execute 'RAILS_ENV=production'
    end
  end

  after :deploy, :migrate_and_restart do
    on roles(:web) do
      within release_path do
        execute :rake, 'db:migrate RAILS_ENV=production'
        execute :touch, 'tmp/restart.txt'
      end
    end
  end
end
