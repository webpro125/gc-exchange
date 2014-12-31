class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :code,                 null: false, limit: 32

      t.timestamps
    end

    add_index :skills, :code, unique: true
  end
end
