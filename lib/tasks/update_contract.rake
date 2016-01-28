desc "Send out email about updated contract"
task :notify_update_contract => :environment do
  notify_update_contract
end

def notify_update_contract
  consultants = Consultant.where(contract_version: 'v1').where("contract_effective_date is not null")
  puts "#{consultants.size} Consultants"
  consultants.each do |consultant|
    puts "#{consultant.id} - #{consultant.email}"
    ContractUpdated.notify(consultant).deliver
  end
end
