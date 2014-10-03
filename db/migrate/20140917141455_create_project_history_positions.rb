class CreateProjectHistoryPositions < ActiveRecord::Migration
  def change
    create_table :project_history_positions do |t|
      t.references :project_history, index: true
      t.references :position, index: true
      t.integer :percentage
    end
  end
end
