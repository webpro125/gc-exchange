class CreateBusinessUnitRoles < ActiveRecord::Migration
  def change
    create_table :business_unit_roles do |t|
      t.boolean :selection_authority, default: false
      t.boolean :approval_authority, default: false
      t.boolean :requisition_authority, default: false
      t.references :account_manager, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
