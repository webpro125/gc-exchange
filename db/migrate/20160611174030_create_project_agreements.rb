class CreateProjectAgreements < ActiveRecord::Migration
  def change
    create_table :project_agreements do |t|
      t.boolean :project_name_agreement, default: true
      t.text :project_name_reason, limit: 500
      t.boolean :project_period_agreement, default: true
      t.text :project_period_reason, limit: 500
      t.boolean :consultant_location_agreement, default: true
      t.text :consultant_location_reason, limit: 500
      t.boolean :travel_authorization_agreement, default: true
      t.text :travel_authorization_reason, limit: 500
      t.boolean :consultant_rate_agreement, default: true
      t.text :consultant_rate_reason, limit: 500
      t.boolean :sow_agreement, default: true
      t.text :sow_reason, limit: 500
      t.integer :status, default: 0
      t.references :consultant, index: true
      t.references :project, index: true
      t.timestamps
    end
    Project.delete_all
  end
end
