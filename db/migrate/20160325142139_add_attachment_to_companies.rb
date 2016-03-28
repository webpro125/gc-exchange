class AddAttachmentToCompanies < ActiveRecord::Migration
  def change
    change_table :companies do |t|
      t.attachment :contract
    end
  end
end
