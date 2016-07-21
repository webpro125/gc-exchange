class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :system_created, :boolean, default: false
    add_column :business_unit_names, :access_token, :string
    add_column :companies, :access_token, :string
  end
end
