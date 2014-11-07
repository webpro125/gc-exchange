class AddConsultantAbstract < ActiveRecord::Migration
  def change
    add_column :consultants, :abstract, :string, limit: 1500
  end
end
