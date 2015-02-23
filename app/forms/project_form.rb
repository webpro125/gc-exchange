require 'reform/form/coercion'

class ProjectForm < Reform::Form
  model :project

  properties :travel_authorization_id, :proposed_start, :proposed_end, :project_name,
             :project_location, :proposed_rate

  validates :travel_authorization_id, presence: true
  validates :proposed_start, presence: true
  validates :proposed_end, presence: true
  validates :project_name, presence: true, length: { in: 2..128 }
  validates :project_location, presence: true, length: { in: 2..500 }
  validates :proposed_rate,
            numericality: { greater_than: 0, less_than_or_equal_to: 5_000 },
            presence:     true
end
