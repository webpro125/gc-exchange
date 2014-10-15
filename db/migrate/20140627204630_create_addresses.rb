class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address1, limit: 128, null: false
      t.string :address2, limit: 128
      t.string :city, limit: 64,      null: false
      t.string :state, limit: 2,      null: false
      t.string :zipcode, limit: 5,    null: false
      t.float :latitude,              null: false
      t.float :longitude,             null: false
      t.belongs_to :consultant

      t.timestamps
    end

    add_index :addresses, :consultant_id, unique: true
  end
end
