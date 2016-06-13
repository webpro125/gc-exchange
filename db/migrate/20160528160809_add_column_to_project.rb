class AddColumnToProject < ActiveRecord::Migration
  def change
    remove_column :projects, :travel_authorization_id
    add_column :projects, :travel_authorization, :boolean
    remove_column :projects, :project_location
    add_column :projects, :consultant_location, :integer
    add_column :projects,  :summarize_statement, :text
  end
end
