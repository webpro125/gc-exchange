class AddMilitaryToMilitary < ActiveRecord::Migration
  def change
    add_column :militaries, :military, :boolean, default: false
  end
end
