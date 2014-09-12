class AddCustomerNameToProjectHistory < ActiveRecord::Migration
  def change
    remove_column :project_histories, :customer_name
    add_reference :project_histories, :customer_name, index: true

    change_column :ranks, :code, :string, null:false, limit: 32
    change_column :clearance_levels, :code, :string, null: false, limit: 32

    remove_column :skills, :created_at, :datetime
    remove_column :skills, :updated_at, :datetime

    remove_column :ranks, :created_at, :datetime
    remove_column :ranks, :updated_at, :datetime

    remove_column :clearance_levels, :created_at, :datetime
    remove_column :clearance_levels, :updated_at, :datetime
  end
end
