class AddApprovalNumberToConsultants < ActiveRecord::Migration
  def change
    add_column :consultants, :approval_number, :integer
    Consultant.approved.order("date_approved").each.with_index do |consultant, index|
      consultant.update(approval_number: index + 1)
    end
  end

end
