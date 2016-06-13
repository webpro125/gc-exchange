class ChangeEmailUniqueToUnitRole < ActiveRecord::Migration
  def change
    remove_index :business_unit_roles, :email
    add_index :business_unit_roles, [:email, :account_manager_id], unique: true
  end
end
