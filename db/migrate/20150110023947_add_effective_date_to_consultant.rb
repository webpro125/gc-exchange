class AddEffectiveDateToConsultant < ActiveRecord::Migration
  def change
    add_column :consultants, :contract_effective_date, :datetime
  end
end
