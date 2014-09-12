class CreateCustomerNames < ActiveRecord::Migration
  def change
    create_table :customer_names do |t|
      t.string :code,         null: false, limit: 32
    end

    add_index :customer_names, :code, unique: true
  end
end
