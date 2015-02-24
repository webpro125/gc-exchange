require 'reform/form/coercion'

class ProjectForm < Reform::Form
  model :project

  property :proposed_start, type: DateTime
  property :proposed_end, type: DateTime
  properties :travel_authorization_id, :project_name, :project_location, :proposed_rate

  validates :travel_authorization_id, presence: true
  validates :proposed_start, presence: true, date: { on_or_after: DateTime.now }
  validates :proposed_end, presence: true, date: { on_or_after: :proposed_start }
  validates :project_location, presence: true, length: { in: 2..500 }
  validates :project_name,
            presence:   true,
            length:     { in: 2..128 },
            uniqueness: { case_sensitive: true }
  validates :proposed_rate,
            numericality: { greater_than: 0, less_than_or_equal_to: 5_000 },
            presence:     true
end
