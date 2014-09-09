class CreateMilitaries < ActiveRecord::Migration
  def change
    create_table :militaries do |t|
      t.references :rank, index: true, null: false
      t.references :clearance_level, index: true, null: false
      t.references :consultant, index: true, null: false
      t.date :investigation_date
      t.date :service_start_date
      t.date :service_end_date

      t.timestamps
    end
  end
end
