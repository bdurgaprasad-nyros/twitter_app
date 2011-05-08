require "capistrano"
require 'rubygems'
require 'active_support'

default_run_options[:pty] = true
set :application, "twitter_app"
set :repository,  "git@github.com:bdurgaprasad-nyros/twitter_app.git"
set :user, 'mahesh'
#~ set :scm,        "git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_to,  "/media/disk/ror_projects/prasad/#{application}"
set :use_sudo, false
#~ set :branch, "master"
set :runner, user

#~ set :repository,"http://bdurgaprasad-nyros@github.com/bdurgaprasad-nyros/twitter_app.git"
set :scm, "git"
set :scm_username, "mahesh"
set :scm_passphrase, "indian"
#~ set :scm_command, "git"

set :deploy_via, :remote_cache
set :password, "12345678"
set :rails_env,       "development"
set :db_name, "twitter_oauth_dev"
set :port_number, 4000
set :bundler_cmd, "bundle install --deployment --without=development,test"





role :web, "172.20.1.33"                          # Your HTTP server, Apache/etc
role :app, "172.20.1.33"                          # This may be the same as your `Web` server
role :db,  "172.20.1.33", :primary => true # This is where Rails migrations will run


 #~ ssh_options[:keys] = %w(/indian/mydetails)
 #~ ssh_options[:paranoid] = false
#~ role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

#~ namespace :migrations do
  #~ desc "Run the Migrations"
  #~ task :up, :roles => :app do
#~ #    run "cd #{current_path}; export RAILS_ENV=production; rake db:drop; rake db:create; rake db:auto:migrate; rake friendly_id:make_slugs MODEL=Item"
     #~ # run "cd #{current_path}; rake db:drop; rake db:create; rake db:auto:migrate; rake friendly_id:make_slugs MODEL=Item"
   #~ run "cd #{current_path}; rake db:auto:migrate;"
  
  #~ end
  #~ task :down, :roles => :app do
#~ #    run "cd #{current_path}; export RAILS_ENV=production; rake db:drop; rake db:create"
    #~ run "cd #{current_path}; rake db:drop; rake db:create"
  #~ end
#~ end
namespace :deploy do

task :symlink_database do
	
 run  "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end


after 'deploy:update_code', :symlink_database

task :gems_install do
	run "cd /media/disk-1/ror_projects/prasad/twitter_app/releases/20110508045420"
	run "rake gems:install"
	end 


task :create_database do
    create_sql = <<-SQL
      CREATE DATABASE #{db_name};
    SQL

    run "mysql --user='root' --password='root' --execute=\"#{create_sql}\""
  end
  end
  
  after 'deploy:update_code', 'deploy:symlink_database'

  
