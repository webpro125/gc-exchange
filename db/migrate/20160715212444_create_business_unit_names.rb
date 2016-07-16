class CreateBusinessUnitNames < ActiveRecord::Migration
  def change
    create_table :business_unit_names do |t|
      t.references :account_manager, index: true
      t.string :name, limit: 128, null: false, default: '', unique: true
      t.timestamps
    end
    remove_column :account_managers, :business_unit_name
    remove_column :business_unit_roles, :account_manager_id
    add_reference :business_unit_roles, :business_unit_name
    add_index :business_unit_roles, :business_unit_name_id, name: 'business_name_role_index'
    BusinessUnitRole.destroy_all
  end
end
