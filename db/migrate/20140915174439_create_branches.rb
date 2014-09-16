class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :code,         null: false, limit: 10

      t.timestamps
    end

    add_index :branches, :code, unique: true
  end
end
