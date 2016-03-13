desc "Tear down and reset the staging db"
# ps xa | grep postgres: | grep $POSTGRESQL_DATABASE | grep -v grep | awk '{print $1}' | sudo xargs kill'
task :reset_staging_db => :environment do
  Rake::Task['db:reset'].invoke
  add_admins
  Rake::Task['import_es'].invoke
end

def add_admins
  admins.each do |admin|
    user = User.new(first_name: 'Staging',
                       last_name: 'Tester',
                       email: admin)
    user.skip_confirmation!
    user.company = company
    user.save
    user.password = "Staging123"
    user.password_confirmation = "Staging123"
    user.save
  end
end

def company
  @company ||= Company.find_by_company_name(Company::GLOBAL_CONSULTANT_EXCHANGE)
end

def admins
  %w(bmills@thoriumllc.com cindy.gillis@globalconsultantexchange.com jill.ramsburg@gmail.com
paul.mears@globalconsultantexchange.com barrie.gillis@globalconsultantexchange.com)
end
