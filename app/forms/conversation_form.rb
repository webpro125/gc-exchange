require 'reform/form/coercion'

class ConversationForm < Reform::Form
  property :subject
  property :message

  validates :message, length: { in: 2..128 }, presence: true
  validates :subject, length: { in: 2..5_000 }, presence: true
end
