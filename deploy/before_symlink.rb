# Chef::Log.info('Running deploy/before_symlink.rb...')
#
# rails_env = new_resource.environment['RAILS_ENV']
# secret_key_base = new_resource.environment['SECRET_KEY_BASE']
# Chef::Log.info("Precompiling assets for #{rails_env}...")
#
# current_release = release_path
#
# execute 'rake assets:precompile' do
#   cwd current_release
#   command 'bundle exec rake assets:precompile'
#   environment 'RAILS_ENV' => rails_env
#   environment 'SECRET_KEY_BASE' => secret_key_base
# end
#
# execute 'rake db:seed' do
#   cwd current_release
#   command 'rake db:seed'
#   environment 'RAILS_ENV' => rails_env
#   environment 'SECRET_KEY_BASE' => secret_key_base
# end
