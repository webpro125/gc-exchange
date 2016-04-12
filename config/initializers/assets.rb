Rails.application.config.assets.precompile += ['*.js', '*.css', '**/*.js', '**/*.css']
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/