class AddUserIdToConsultant < ActiveRecord::Migration
  def change
    add_column :consultants, :user_id,   :integer,    default: 0
    remove_column :consultants, :email
    remove_column :consultants, :encrypted_password
    remove_column :consultants, :reset_password_token
    remove_column :consultants, :reset_password_sent_at
    remove_column :consultants, :remember_created_at
    remove_column :consultants, :sign_in_count
    remove_column :consultants, :current_sign_in_at
    remove_column :consultants, :last_sign_in_at
    remove_column :consultants, :current_sign_in_ip
    remove_column :consultants, :last_sign_in_ip
  end
end
