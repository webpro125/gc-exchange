class CreateTravelAuthorizations < ActiveRecord::Migration
  def change
    create_table :travel_authorizations do |t|
      t.string :code, limit: 32, null: false
      t.string :label, limit: 256, null: false
    end
    add_index :travel_authorizations, :code, unique: true
    add_index :travel_authorizations, :label, unique: true
  end
end
