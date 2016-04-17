class CreateAccountManagers < ActiveRecord::Migration
  def change
    create_table :account_managers do |t|
      t.string :business_unit_name, null:false, default: "", limit: 32
      t.string :corporate_title, limit: 32
      t.string :phone, limit: 32
      t.string :avatar
      t.string :email,              null: false, default: ""
      t.string :first_name,       null: false, limit: 24
      t.string :last_name,        null: false, limit: 24
      t.string :access_token

      t.references :user, index: true
      t.references :company, index: true
      t.timestamps
    end
    add_index :account_managers, :email,                unique: true
  end
end
