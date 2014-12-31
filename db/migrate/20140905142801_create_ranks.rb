class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :code,         null: false, limit: 10

      t.timestamps
    end
  end
end
