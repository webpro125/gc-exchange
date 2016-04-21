class AddColumnsToBusinessUnitRoles < ActiveRecord::Migration
  def change
    add_column :business_unit_roles, :email, :string, null: false, default: ""
    add_column :business_unit_roles, :first_name, :string, null: false, limit: 24
    add_column :business_unit_roles, :last_name, :string, null: false, limit: 24
    add_index :business_unit_roles, :email, unique: true
  end
end
