class AcceptColumnsToBusinessRole < ActiveRecord::Migration
  def change
    add_column :business_unit_roles, :ra_accept, :boolean, default: false
    add_column :business_unit_roles, :sa_accept, :boolean, default: false
    add_column :business_unit_roles, :aa_accept, :boolean, default: false
    add_column :business_unit_roles, :phone, :string, limit: 32
    add_column :business_unit_roles, :accept_token, :string
  end
end
