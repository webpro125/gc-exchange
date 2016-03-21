class AddIndexToConsultant < ActiveRecord::Migration
  def change
    remove_column :consultants, :user_id
    add_reference :consultants, :user, index: true, unique: true
  end
end
