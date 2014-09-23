Chef::Log.info('Running deploy/before_symlink.rb...')

rails_env = new_resource.environment['RAILS_ENV']
current_release = release_path

Chef::Log.info("Precompiling assets for #{rails_env}...")
execute 'rake assets:precompile' do
  cwd current_release
  command 'bundle exec rake assets:precompile'
  environment 'RAILS_ENV' => rails_env
end

Chef::Log.info("Seeding database for #{rails_env}...")
execute 'rake db:seed' do
  cwd current_release
  command 'bundle exec rake db:seed'
  environment 'RAILS_ENV' => rails_env
end
