class AddExtToPhone < ActiveRecord::Migration
  def change
    add_column :phones, :ext, :string
  end
end
