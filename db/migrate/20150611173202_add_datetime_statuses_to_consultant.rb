class AddDatetimeStatusesToConsultant < ActiveRecord::Migration
  def change
    add_column :consultants, :date_on_hold, :datetime
    add_column :consultants, :date_pending_approval, :datetime
    add_column :consultants, :date_approved, :datetime
    add_column :consultants, :date_rejected, :datetime
  end

  def data
    Consultant.find_each do |c|
      if c.approved_status.label = "Pending Approval"
        c.date_pending_approval = DateTime.now
      end

      if c.approved_status.label = "On Hold"
        c.date_on_hold = DateTime.now
      end

      if c.approved_status.label = "Approved"
        c.date_approved = DateTime.now
      end

      if c.approved_status.label = "Rejected"
        c.date_rejected = DateTime.now
      end
      c.save
    end
  end
end
