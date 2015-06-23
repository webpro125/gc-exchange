class RemoveAllPendingApprovalConsultants < ActiveRecord::Migration
  def change
  end

  def data
    Consultant.pending_approval.each do |c|
      ConsultantIndexer.perform_async(:destroy, c.id)
    end
  end
end
