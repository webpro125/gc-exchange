class CreateClearanceLevels < ActiveRecord::Migration
  def change
    create_table :clearance_levels do |t|
      t.string :code,         null: false, limit: 10

      t.timestamps
    end
  end
end
