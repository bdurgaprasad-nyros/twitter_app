load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy' # remove this line to skip loading any of the default tasks

 task :start, :roles => :app do
    link_app
    host_configuration
    set_perms #creating symbolic link to public screws up perms
  end

 task :restart, :roles => :app do
   start
 end




desc "Link up the application. This creates/updates a standard symbolic link 
from the application location to a sub-folder of your ~/public_html (a.k.a, ~/www)"
task :link_app do
  run "rm -rf ~/www/#{application} && ln -s #{current_path}/public ~/www/#{application}"
end


desc "Prefer the webhost configuration files. Calling this task replaces
 public/.htaccess and the public/dispatch.* files over those from svn from 
 a test application I've setup by hand on the hostmonster.com following the 
 directions here."
task :host_configuration do
  #I've tried this same step a thousand different 
  #ways and this is the only one that worked :/
  files = %w(.htaccess dispatch.rb dispatch.cgi dispatch.fcgi)
  run "cd ~/www/#{application}; " + 
  (files.collect { |file| "rm #{file} && cp ~/rails/HM_CONFIG/#{file} ."}.join(" && "))
end


desc "Set the proper permissions for directories and files.  Specify a 
list of folders and files with `set :chmod755` in config/deploy.rb"
task :set_perms, :roles => [:app, :db, :web] do
  run(chmod755.collect { |i| "chmod 755 #{current_path}/#{i}" }.join(" && "))
end


desc "Restarting after deployment"
#this might not be necessary on hostmonster....
task :after_deploy, :roles => [:app, :db, :web] do
  run "sed 's/# ENV\\[/ENV\\[/g' #{deploy_to}/current/config/environment.rb > #{deploy_to}/current/config/environment.temp"
  run "mv #{deploy_to}/current/config/environment.temp #{deploy_to}/current/config/environment.rb"
end


desc "Returns last lines of log file. Usage: cap log [-s lines=100] [-s rails_env=production]"  
task :log do
  lines     = variables[:lines] || 100
  rails_env = variables[:rails_env] || 'production'  
  run "tail -n #{lines} #{shared_path}/log/#{rails_env}.log" do |ch, stream, out|  
    puts out  
  end
end

# DATABASE only  
after 'deploy:update_code', 'db:symlink'
namespace :db do
  desc "Make symlink for database yaml using the #{db_type} implementation."
  # this is a task for my custom svn setup... you probably
  # wont need if you have a database.yml file checked into svn
  task :symlink do
    run "ln -nfs #{release_path}/config/#{db_type}.database.yml #{release_path}/config/database.yml"
  end
end