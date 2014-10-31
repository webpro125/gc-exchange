class AddAddressFields < ActiveRecord::Migration
  def change
    add_column :addresses, :address, :text, limit: 512, null: false

    remove_column :addresses, :address1, :string, limit: 128, null: false
    remove_column :addresses, :address2, :string, limit: 128
    remove_column :addresses, :city, :string, limit: 64,      null: false
    remove_column :addresses, :state, :string, limit: 2,      null: false
    remove_column :addresses, :zipcode, :string, limit: 5,    null: false
  end
end
