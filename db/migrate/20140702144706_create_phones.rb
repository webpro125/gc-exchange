class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.references :phoneable,          polymorphic: true
      t.integer :phone_type_id,         null: false
      t.string :number,                 null: false, limit: 32

      t.timestamps
    end

    add_index :phones, [:phoneable_id, :phoneable_type]
    add_index :phones, [:phone_type_id]
  end
end
