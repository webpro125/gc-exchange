class ChangeProjectHistoriesTable < ActiveRecord::Migration
  def up
    change_column :project_histories, :client_company, :string, limit: 512
    change_column :project_histories, :client_poc_name, :string, limit: 256
  end

  def down
    change_column :project_histories, :client_company, :string, limit: 128
    change_column :project_histories, :client_poc_name, :string, limit: 64
  end
end
