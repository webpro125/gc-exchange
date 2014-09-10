class CreateMilitaries < ActiveRecord::Migration
  def change
    create_table :militaries do |t|
      t.references :rank, index: true
      t.references :clearance_level, index: true
      t.references :consultant, index: true, null: false
      t.date :investigation_date
      t.date :clearance_expiration_date
      t.date :service_start_date
      t.date :service_end_date

      t.timestamps
    end
  end
end
