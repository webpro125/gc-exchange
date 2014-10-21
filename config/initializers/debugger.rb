if (Rails.env.development?) && File.split($PROGRAM_NAME).last != 'rake'
  require 'byebug'

  Byebug.start_server 'localhost', ENV['RUBY_DEBUG_PORT'].to_i
end
