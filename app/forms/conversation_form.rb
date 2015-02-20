require 'reform/form/coercion'

class ConversationForm < Reform::Form
  property :subject
  property :message

  validates :message, presence: true
  validates :subject, presence: true
end
