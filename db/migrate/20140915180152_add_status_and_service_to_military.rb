class AddStatusAndServiceToMilitary < ActiveRecord::Migration
  def change
    add_column :militaries, :clearance_status, :boolean, null: false, default: false
    add_reference :militaries, :branch, index: true
  end
end
