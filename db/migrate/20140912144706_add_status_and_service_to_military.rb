class AddStatusAndServiceToMilitary < ActiveRecord::Migration
  def change
    add_column :militaries, :clearance_status, :boolean
    add_column :militaries, :service_branch, :string
  end
end
