class AddSowToProject < ActiveRecord::Migration
  def change
    add_column :projects, :sow, :string
    add_attachment :projects, :sow
  end
end
