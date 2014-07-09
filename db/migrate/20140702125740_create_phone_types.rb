class CreatePhoneTypes < ActiveRecord::Migration
  def change
    create_table :phone_types do |t|
      t.string :code,         null: false, limit: 32
    end

    add_index :phone_types, :code, unique: true
  end
end
