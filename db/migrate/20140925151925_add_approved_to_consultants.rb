class AddApprovedToConsultants < ActiveRecord::Migration
  def change
    add_column :consultants, :approved, :boolean, default: false, null: false
    add_index :consultants, :approved
  end
end
