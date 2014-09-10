class CreateProjectHistoryDisciplines < ActiveRecord::Migration
  def change
    create_table :project_history_disciplines do |t|
      t.references :discipline, index: true, null: false
      t.references :project_history, index: true, null: false

      t.timestamps
    end
  end
end
