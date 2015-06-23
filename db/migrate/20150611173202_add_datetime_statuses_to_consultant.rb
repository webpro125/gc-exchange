class AddDatetimeStatusesToConsultant < ActiveRecord::Migration
  def change
    add_column :consultants, :date_on_hold, :datetime
    add_column :consultants, :date_pending_approval, :datetime
    add_column :consultants, :date_approved, :datetime
    add_column :consultants, :date_rejected, :datetime
  end

  def data
    Consultant.each do |c|
      c.date_on_hold = DateTime.now
      c.date_pending_approval = DateTime.now
      c.date_approved = DateTime.now
      c.date_rejected = DateTime.now
    end
  end
end
