class RemoveColumnsFromConsultants < ActiveRecord::Migration
  def change
    remove_column :consultants, :confirmation_token
    remove_column :consultants, :first_name
    remove_column :consultants, :last_name
  end
end
