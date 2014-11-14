class CreateDegrees < ActiveRecord::Migration
  def change
    create_table :degrees do |t|
      t.string :code, limit: 32, null: false
      t.string :label, limit: 256, null: false
    end
    add_index :degrees, :code, unique: true
    add_index :degrees, :label, unique: true
  end
end
