class AddPrimaryToPhone < ActiveRecord::Migration
  def change
    add_column :phones, :primary, :boolean, default: false
  end
end
