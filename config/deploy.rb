set :application, "w2task"
set :domain,  "72.2.118.101"
set :server_name, "staging.bojica.com"
set :server_alias, "*.staging.bojica.com"
set :user,  "w2task"
set :repository,  "git@github.com:bojicas/w2task.git"
set :local_repository,   "#{File.dirname(__FILE__)}/../"

set :use_sudo,    false

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/w2task/web/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
# keep a cached code checkout on the server, and do updates each time (more efficient)
set :deploy_via, :remote_cache
set :branch, "master"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end