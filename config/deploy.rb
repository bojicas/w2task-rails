require 'erb'
require 'config/accelerator/accelerator_tasks'
 
set :application, "w2task" #matches names used in smf_template.erb
set :repository,  "git@github.com:bojicas/w2task.git"
set :local_repository,   "#{File.dirname(__FILE__)}/../" 
 
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}" # I like this location
 
set :user, 'w2task'
set :runner, 'w2task'
 
# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
 
# keep a cached code checkout on the server, and do updates each time (more efficient)
set :deploy_via, :remote_cache
set :branch, "master"
 
# Set the path to svn and rake if needed(Does not seem to be necessary on the newpkgsrc templated accelerators, but if needed change path to /opt/local/bin/ )
# set :git, "/opt/local/bin/git"
# set :rake, "/opt/local/bin/rake"
 
 
set :domain, '72.2.118.101'
 
role :app, domain
role :web, domain
role :db,  domain, :primary => true
 
set :server_name, "staging.bojica.com"
set :server_alias, "*.staging.bojica.com"
 
# Example dependancies
depend :remote, :command, :gem
depend :remote, :gem, :money, '>=1.7.1'
depend :remote, :gem, :mongrel, '>=1.0.1'
depend :remote, :gem, :image_science, '>=1.1.3'
depend :remote, :gem, :rake, '>=0.7'
depend :remote, :gem, :BlueCloth, '>=1.0.0'
depend :remote, :gem, :RubyInline, '>=3.6.3'
 
deploy.task :restart do
  accelerator.smf_restart
  accelerator.restart_apache
end
 
deploy.task :start do
  accelerator.smf_start
  accelerator.restart_apache
end
 
deploy.task :stop do
  accelerator.smf_stop
  accelerator.restart_apache
end
 
after :deploy, 'deploy:cleanup'