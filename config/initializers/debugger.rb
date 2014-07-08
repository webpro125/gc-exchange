if (Rails.env.development?) && File.split($0).last != 'rake'
  require 'byebug'

  Byebug.start_server 'localhost', 1234
end
