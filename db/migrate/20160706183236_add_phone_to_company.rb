class AddPhoneToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :work_phone, :string, limit: 32, default: ''
    rename_column :companies, :phone, :cell_phone
    add_column :companies, :address, :string, limit: 128, defatult: ''
  end
end
