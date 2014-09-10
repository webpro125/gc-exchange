if (Rails.env.development?) && File.split($PROGRAM_NAME).last != 'rake'
  require 'byebug'

  Byebug.start_server 'localhost', 1234
end
