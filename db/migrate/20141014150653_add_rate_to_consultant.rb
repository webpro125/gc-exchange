class AddRateToConsultant < ActiveRecord::Migration
  def change
    add_column :consultants, :rate, :decimal, precision: 8, scale: 2
  end
end
