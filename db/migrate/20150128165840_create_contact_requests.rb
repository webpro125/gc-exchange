class CreateContactRequests < ActiveRecord::Migration
  def change
    create_table :contact_requests do |t|
      t.references :consultant, index: true, null: false
      t.references :company, index: true, null: false
      t.boolean :approved
      t.date :project_start
      t.date :project_end

      t.timestamps
    end
  end
end
