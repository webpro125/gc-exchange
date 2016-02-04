desc "Tear down and import model data into elastic search"
task :import_es => :environment do
  import_es
end

def import_es
  Consultant.import(force: true)
  Skill.import(force: true)
end
