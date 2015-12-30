class AddContractVersionToConsultants < ActiveRecord::Migration
  def change
    add_column :consultants, :contract_version, :string
    Consultant.where("contract_effective_date is not null").update_all(contract_version: "v1")
  end
end
