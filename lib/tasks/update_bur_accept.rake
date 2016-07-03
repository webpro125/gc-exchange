desc "Tear down and import model data into elastic search"
task :update_bur_accept => :environment do
  update_bur_accept
end

def update_bur_accept
  BusinessUnitRole.where('aa_accept = ? or ra_accept = ? or sa_accept = ?', true, true, true).find_each do |unit_role|
    AccountManagerMailer.delay.assigned_role(unit_role.user, '', unit_role.accept_token)
  end
end
