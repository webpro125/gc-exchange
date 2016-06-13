class CreateWorkLocationAddresses < ActiveRecord::Migration
  def change
    create_table :work_location_addresses do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :st
      t.string :zip_code
      t.references :project
      t.timestamps
    end
  end
  add_column :projects, :rate_approve, :boolean
end
