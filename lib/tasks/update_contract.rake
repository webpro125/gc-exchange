desc "Send out email about updated contract"
task :notify_update_contract => :environment do
  notify_update_contract
end

def notify_update_contract
  Consultant.where(contract_version: 'v1').where("contract_effective_date is not null").each do |consultant|
    ContractUpdated.notify(consultant).deliver
  end
end
