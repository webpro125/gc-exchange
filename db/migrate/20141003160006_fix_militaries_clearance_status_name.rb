class FixMilitariesClearanceStatusName < ActiveRecord::Migration
  def change
    rename_column :militaries, :clearance_status, :clearance_active
  end
end
