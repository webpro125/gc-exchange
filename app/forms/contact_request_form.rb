require 'reform/form/coercion'

class ContactRequestForm < Reform::Form
  model :contact_request

  property :message
  property :subject

  validates :message, presence: true
  validates :subject, presence: true
end
