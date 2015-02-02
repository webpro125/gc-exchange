require 'reform/form/coercion'

class ContactRequestForm < Reform::Form
  model :contact_request

  property :project_start, type: DateTime
  property :project_end, type: DateTime
  property :message

  validates :project_start, presence: true
  validates :project_end, date: { on_or_after: :project_start },
            allow_blank: true, if: ->() { project_start.present? }
  validates :message, presence: true
end
