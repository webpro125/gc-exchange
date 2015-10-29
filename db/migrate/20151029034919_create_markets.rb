class CreateMarkets < ActiveRecord::Migration
  def change
      create_table :markets do |t|
        t.string :code
        t.string :label
        t.integer :market_id
      end
  end
end
