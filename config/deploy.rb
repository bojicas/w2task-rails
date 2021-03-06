require 'erb'
require 'config/accelerator/accelerator_tasks'
 
set :application, "w2task" #matches names used in smf_template.erb
set :repository,  "git@github.com:bojicas/w2task.git"
set :local_repository,   "#{File.dirname(__FILE__)}/../" 
 
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}" # I like this location

# This is necessary to start and stop all your mongrels with the alternate-SMF approach
# set :service_list, "`svcs -H -o FMRI svc:application/mongrel/#{application}-production`"
 
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
 
set :server_name, "w2task.com"
set :server_alias, "*.w2task.com"
 
# Example dependancies
depend :remote, :command, :gem
depend :remote, :gem, :money, '>=1.7.1'
depend :remote, :gem, :mongrel, '>=1.0.1'
depend :remote, :gem, :image_science, '>=1.1.3'
depend :remote, :gem, :rake, '>=0.7'
depend :remote, :gem, :BlueCloth, '>=1.0.0'
depend :remote, :gem, :RubyInline, '>=3.6.3'
 

 deploy.task :restart do
   run "touch #{current_path}/tmp/restart.txt"
 end
 
 after :deploy, 'deploy:cleanup'