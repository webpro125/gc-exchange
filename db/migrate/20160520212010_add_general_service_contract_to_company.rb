class AddGeneralServiceContractToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :gsc, :string
    change_table :companies do |t|
      t.attachment :gsc
    end
  end
end
