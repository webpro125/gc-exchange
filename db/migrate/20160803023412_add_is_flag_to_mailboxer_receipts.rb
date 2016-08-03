class AddIsFlagToMailboxerReceipts < ActiveRecord::Migration
  def change
    add_column :mailboxer_receipts, :is_flag, :boolean, default: false
  end
end
