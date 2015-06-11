class AddDatetimeStatusesToConsultant < ActiveRecord::Migration
  def change
    add_column :consultants, :date_on_hold, :datetime
    add_column :consultants, :date_pending_approval, :datetime
    add_column :consultants, :date_approved, :datetime
    add_column :consultants, :date_rejected, :datetime
  end
end
