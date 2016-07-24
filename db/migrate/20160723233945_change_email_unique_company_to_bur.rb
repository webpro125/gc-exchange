class ChangeEmailUniqueCompanyToBur < ActiveRecord::Migration
  def change
    add_reference :business_unit_roles, :company
    add_index :business_unit_roles, [:email, :company_id]
    BusinessUnitRole.find_each do |bur|
      if bur.business_unit_name.present?
        bur.company_id = bur.business_unit_name.account_manager.company_id
        bur.save!
      else
        bur.destroy!
      end
    end
  end
end