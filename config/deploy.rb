set :application, "testapp"
set :repository,  "git@github.com:bdurgaprasad-nyros/twitter_app.git"
set :user, 'mahesh'
set :scm,        "git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_to,  "/media/disk-1/ror_projects/prasad/#{application}"


role :web, "172.20.1.33"                          # Your HTTP server, Apache/etc
role :app, "172.20.1.33"                          # This may be the same as your `Web` server
role :db,  "172.20.1.33", :primary => true # This is where Rails migrations will run
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

