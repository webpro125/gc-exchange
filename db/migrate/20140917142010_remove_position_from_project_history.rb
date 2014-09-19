class RemovePositionFromProjectHistory < ActiveRecord::Migration
  def change
    remove_reference :project_histories, :position, index: true
  end
end
