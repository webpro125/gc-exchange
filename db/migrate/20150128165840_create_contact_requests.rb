class CreateContactRequests < ActiveRecord::Migration
  def change
    create_table :contact_requests do |t|
      t.references :consultant, index: true, null: false
      t.references :user, index: true, null: false
      t.boolean :approved
      t.date :project_start
      t.date :project_end
      t.text   :message,          null: false, limit: 5000

      t.timestamps
    end
  end
end
