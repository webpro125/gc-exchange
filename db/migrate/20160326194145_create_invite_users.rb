class CreateInviteUsers < ActiveRecord::Migration
  def change
    create_table :invite_users do |t|
      t.string :email,              null: false, default: ""
      t.string :first_name,       null: false, limit: 24
      t.string :last_name,        null: false, limit: 24
      t.string :token
      t.references :company, index: true, null: false
      t.timestamps
    end
  end
end
