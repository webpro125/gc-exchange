class AddEmailContentToAccountManager < ActiveRecord::Migration
  def change
    add_column :account_managers, :email_content, :text, default: '', null: false
  end
end
