class AddConsultantAbstract < ActiveRecord::Migration
  def change
    add_column :consultants, :abstract, :string, limit: 1500
    add_column :consultants, :us_citizen, :boolean, default: false, required: true
  end
end
