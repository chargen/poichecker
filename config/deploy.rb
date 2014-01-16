set :application, 'matchy'
set :repo_url, 'git@github.com:sozialhelden/matchy.git'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/apps/matchy/staging'
# set :scm, :git

 set :format, :pretty
 set :log_level, :debug
 set :pty, true

set :linked_files, %w{config/database.yml config/osm.yml config/initializers/secret_token.rb}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :rbenv_type, :system # :user or :system, depends on your rbenv setup
set :rbenv_ruby, '2.0.0-p353'
set :rbenv_custom_path, '/opt/rbenv'

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end

namespace :unicorn do

  task :reload do
    on roles(:app), in: :sequence, wait: 5 do
      execute '/etc/init.d/unicorn_matchy upgrade'
    end
  end


  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute '/etc/init.d/unicorn_matchy restart'
    end
  end

end

after 'deploy:restart', 'unicorn:reload' # ZERO DOWNTIME DEPLOYMENT
