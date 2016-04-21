class AddAttachmentToAccountManager < ActiveRecord::Migration
  def change
    change_table :account_managers do |t|
      t.attachment :avatar
    end
  end
end
