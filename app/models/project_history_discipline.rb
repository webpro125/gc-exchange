class ProjectHistoryDiscipline < ActiveRecord::Base
  belongs_to :discipline
  belongs_to :project_history

  validates :discipline, presence: true
  validates :project_history, presence: true
end
