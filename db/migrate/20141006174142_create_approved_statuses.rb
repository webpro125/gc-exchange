class CreateApprovedStatuses < ActiveRecord::Migration
  def change
    create_table :approved_statuses do |t|
      t.string :code, limit: 32
    end
    add_index :approved_statuses, :code, unique: true
  end
end
