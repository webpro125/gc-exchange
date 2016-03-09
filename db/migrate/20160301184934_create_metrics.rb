class CreateMetrics < ActiveRecord::Migration
  def change
    enable_extension 'hstore'

    create_table :metrics do |t|
      t.string :loggable_type
      t.integer :loggable_id
      t.string :metric_type, null: false
      t.hstore :params, using: :gist

      t.timestamps
    end
  end
end
