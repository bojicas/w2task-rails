set :application, "w2task"
set :domain,  "72.2.118.101"
set :server_name, "staging.bojica.com"
set :server_alias, "*.staging.bojica.com"
set :user,  "w2task"
set :runner, nil
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
# set :deploy_via, :remote_cache
set :branch, "master"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  desc "Tell Passenger to restart the app."
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    # run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets/avatars #{release_path}/public/avatars"
    run "ln -nfs #{release_path}/public /home/w2task/web/public"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :setup_assets do
    run "mkdir -p #{shared_path}/assets/avatars/"
  end  

  task :fix_script_perms do
    run "chmod 755 #{release_path}script/spin"
  end  
end

after 'deploy:update_code', 'deploy:symlink_shared'
after 'deploy:symlink_shared', 'deploy:fix_script_perms'
