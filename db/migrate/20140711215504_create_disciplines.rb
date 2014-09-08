class CreateDisciplines < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.string :code, limit: 32
    end

    add_index :disciplines, :code, unique: true
  end
end
