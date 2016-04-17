class AddEmailToCompany < ActiveRecord::Migration
  def change
    drop_table :invite_users if ActiveRecord::Base.connection.table_exists? :invite_users
    add_column :companies, :email, :string, null: false, default: ""
    add_index :companies, :email,                unique: true
    Company.find_each do |c|
      user = User.find(c.owner_id)
      c.email = user.email
      c.first_name = user.first_name
      c.last_name = user.last_name
      c.phone = '123-123-1234'
      c.contract_start = Date.today
      c.contract_end = (Date.today + 100)
      c.save!
    end
  end
end
