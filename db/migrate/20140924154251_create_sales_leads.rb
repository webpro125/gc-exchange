class CreateSalesLeads < ActiveRecord::Migration
  def change
    create_table :sales_leads do |t|
      t.string :first_name,       null: false, limit: 24
      t.string :last_name,        null: false, limit: 24
      t.string :company_name,     null: false, limit: 128
      t.string :phone_number,     null: false
      t.string :email,            null: false, limit: 128
      t.text   :message,          null: false, limit: 5000

      t.timestamps
    end

    add_index :sales_leads, :email, unique: true
  end
end

