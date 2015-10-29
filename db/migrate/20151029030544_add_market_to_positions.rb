class AddMarketToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :market_id, :integer, :default => 1
  end
end
