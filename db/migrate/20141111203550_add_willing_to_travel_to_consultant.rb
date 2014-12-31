class AddWillingToTravelToConsultant < ActiveRecord::Migration
  def change
    add_column :consultants, :willing_to_travel, :boolean, default: true
  end
end
