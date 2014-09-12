class AddCustomerNameToProjectHistory < ActiveRecord::Migration
  def change
    remove_column :project_histories, :customer_name
    add_reference :project_histories, :customer_name, index: true
  end
end
