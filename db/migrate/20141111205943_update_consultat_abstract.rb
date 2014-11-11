class UpdateConsultatAbstract < ActiveRecord::Migration
  def up
    change_column :consultants, :abstract, :text, limit: 1500
  end
  def down
    change_column :consultants, :abstract, :string
  end
end
