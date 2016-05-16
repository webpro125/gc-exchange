#Rails.application.config.assets.precompile += ['*.js', '*.css', '**/*.js', '**/*.css']
Rails.application.config.assets.precompile += [
  'application_new.css',
  'application_admin.css',
  'debug.css',
  'sections/*.css',
  'application_new.js',
  'application_admin.js',
  'sections/*.js',
]
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
