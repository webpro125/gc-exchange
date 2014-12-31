class ProjectHistoryPosition < ActiveRecord::Base
  belongs_to :project_history, inverse_of: :project_history_positions
  belongs_to :position

  validates :position, presence: true
  validates :project_history, presence: true, uniqueness: { scope: :position }
end
