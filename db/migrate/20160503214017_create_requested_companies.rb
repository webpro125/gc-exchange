class CreateRequestedCompanies < ActiveRecord::Migration
  def change
    create_table :requested_companies do |t|
      t.string :company_name, null: false, limit: 128
      t.string :work_phone, null: false, limit: 32
      t.string :cell_phone, null: false, limit: 32
      t.string :work_phone_ext
      t.text :help_content
      t.boolean :is_read, default: false
      t.references :user, index: true
      t.timestamps
    end
    add_index :requested_companies, :company_name,                unique: true
  end
end
