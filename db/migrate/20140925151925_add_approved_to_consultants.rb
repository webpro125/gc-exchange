class AddApprovedToConsultants < ActiveRecord::Migration
  def change
    add_reference :consultants, :approved_status, index: true, null: false, default: 1
  end
end
