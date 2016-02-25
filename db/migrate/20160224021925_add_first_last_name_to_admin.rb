class AddFirstLastNameToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :first_name,   :string,    null: false, limit: 24
    add_column :admins, :last_name,    :string,   null: false, limit: 24
  end
end
