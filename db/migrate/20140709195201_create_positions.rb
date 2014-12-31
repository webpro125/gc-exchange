class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :code,       null: false, limit: 32
    end

    add_index :positions, :code, unique: true
  end
end
