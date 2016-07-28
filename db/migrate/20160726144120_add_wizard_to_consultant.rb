class AddWizardToConsultant < ActiveRecord::Migration
  def change
    Consultant.find_each do |consultant|
      consultant.wizard_step = 'wicked_finish' if consultant.project_histories.any?
      consultant.save!
    end
  end
end
