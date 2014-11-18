class AddWizardStepToConsultant < ActiveRecord::Migration
  def change
    add_column :consultants, :wizard_step, :string
  end
end
