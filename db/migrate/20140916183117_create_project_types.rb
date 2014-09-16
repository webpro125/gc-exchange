class CreateProjectTypes < ActiveRecord::Migration
  def change
    create_table :project_types do |t|
      t.string :code, limit: 32, null: false
    end

    add_index :project_types, :code, unique: true
  end
end
