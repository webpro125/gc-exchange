class AddColumnsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :first_name,   :string, null: false, default: ""
    add_column :companies, :last_name,   :string, null: false, default: ""
    add_column :companies,  :phone, :string,  null: false, limit: 32, default: ""
    add_column :companies, :contract_start, :date
    add_column :companies, :contract_end, :date
    add_column :companies, :require_contract_rider, :boolean, default: false
  end
end
