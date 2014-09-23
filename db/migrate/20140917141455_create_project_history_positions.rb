class CreateProjectHistoryPositions < ActiveRecord::Migration
  def change
    create_table :project_history_positions do |t|
      t.references :project_history, index: true
      t.references :position, index: true
      t.integer :percentage
    end

    add_index :project_history_positions, [:project_history_id, :position], unique: true
  end
end
