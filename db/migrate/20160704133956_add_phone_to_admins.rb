class AddPhoneToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :phone, :string, default: ''
  end
end
