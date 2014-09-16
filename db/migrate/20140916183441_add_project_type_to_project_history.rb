class AddProjectTypeToProjectHistory < ActiveRecord::Migration
  def change
    add_reference :project_histories, :project_type, index: true
  end
end
