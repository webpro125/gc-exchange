class DropDisciplines < ActiveRecord::Migration
  def up
    drop_table :project_history_disciplines
    drop_table :disciplines
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
