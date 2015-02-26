ignore %r{^(public|app/assets)}

guard :bundler do
  watch('Gemfile')
end

guard 'migrate', seed: true, run_on_start: true do
  watch(%r{^db/migrate/(\d+).+\.rb})
  watch('db/seeds.rb')
end

guard 'brakeman', run_on_start: false do
  watch(%r{^app/.+\.(erb|haml|rhtml|rb)$})
  watch(%r{^config/.+\.rb$})
  watch(%r{^lib/.+\.rb$})
  watch('Gemfile')
end

guard :rubocop, all_on_start: false do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard :rspec, cmd: 'spring rspec', all_after_pass: true, failed_mode: :keep do
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }

  # Rails example
  watch(%r{^spec/support/(.+)\.rb$})                 { 'spec' }
  watch('config/routes.rb')                          { 'spec/routing' }
  watch(%r{^app/controllers/(application|consultant|company)_controller.rb}) { 'spec/controllers' }
  watch(%r{^app/validators/(.+)_(validator)\.rb$})   { 'spec/models' }
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})         { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) do |m|
    ["spec/routing/#{m[1]}_routing_spec.rb",
     "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb"]
  end
  watch(%r{^app/(.+)\.rb$})                          { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/policies/(.+)_(policy)\.rb$}) do |m|
    ["spec/policies/#{m[1]}_#{m[2]}_spec.rb",
     "spec/controllers/#{m[1]}s_controller_spec.rb"]
  end

  watch(%r{^spec/.+_spec\.rb$})

  # Factories
  require 'active_support/inflector'
  watch(%r{^spec/factories/(.+)\.rb$}) { |m| "spec/models/#{m[1].singularize}_spec.rb" }
end
