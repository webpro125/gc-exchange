class CreateContactRequests < ActiveRecord::Migration
  def change
    create_table :contact_requests do |t|
      t.references :consultant, index: true, null: false
      t.references :user, index: true, null: false
      t.references :communication, index: true, null: false
      t.date :project_start
      t.date :project_end
      t.text   :message,          limit: 5000, null: false
      t.decimal :project_rate, precision: 8, scale: 2
      t.integer :contact_status,          default: 0

      t.timestamps
    end
  end
end
