class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :consultant, index: true, null: false
      t.references :user, index: true, null: false
      t.references :travel_authorization, index: true
      t.date :proposed_start
      t.date :proposed_end
      t.decimal :proposed_rate, precision: 8, scale: 2
      t.integer :contact_status,          default: 0
      t.string :project_name, limit: 128
      t.text :project_location, limit: 500

      t.timestamps
    end
  end
end
