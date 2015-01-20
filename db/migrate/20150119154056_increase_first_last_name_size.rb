class IncreaseFirstLastNameSize < ActiveRecord::Migration
  def change
    change_column :consultants, :first_name, :string, null: false, limit: 64
    change_column :consultants, :last_name, :string, null: false, limit: 64
  end
end
