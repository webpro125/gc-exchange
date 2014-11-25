class AddLabelToLookups < ActiveRecord::Migration
  def change
    add_column :certifications, :label, :string, limit: 256, null: false
    add_column :positions, :label, :string, limit: 256, null: false
    add_column :clearance_levels, :label, :string, limit: 256, null: false
    add_column :phone_types, :label, :string, limit: 256, null: false
    add_column :ranks, :label, :string, limit: 256, null: false
    add_column :branches, :label, :string, limit: 256, null: false
    add_column :approved_statuses, :label, :string, limit: 256, null: false
    add_column :customer_names, :label, :string, limit: 256, null: false
    add_column :project_types, :label, :string, limit: 256, null: false
  end

  def data
    Certification.delete_all
    Position.delete_all
    ClearanceLevel.delete_all
    PhoneType.delete_all
    Rank.delete_all
    Branch.delete_all
    ApprovedStatus.delete_all
    CustomerName.delete_all
    ProjectType.delete_all
  end
end
