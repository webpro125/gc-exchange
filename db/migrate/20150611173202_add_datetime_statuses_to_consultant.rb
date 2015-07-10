class AddDatetimeStatusesToConsultant < ActiveRecord::Migration
  def change
    add_column :consultants, :date_on_hold, :datetime
    add_column :consultants, :date_pending_approval, :datetime
    add_column :consultants, :date_approved, :datetime
    add_column :consultants, :date_rejected, :datetime
  end

  def data
    Consultant.find_each do |c|
      if c.pending_approval?
        c.date_pending_approval = DateTime.now
      end

      if c.on_hold?
        c.date_on_hold = DateTime.now
      end

      if c.approved?
        c.date_approved = DateTime.now
        c.date_pending_approval = DateTime.now
      end

      if c.rejected?
        c.date_rejected = DateTime.now
        c.date_pending_approval = DateTime.now
      end
      c.save
    end
  end
end
