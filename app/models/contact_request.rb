class ContactRequest < ActiveRecord::Base
  enum contact_status: [:pending, :approved, :rejected, :hired, :fired, :agreed_to_terms,
                        :rejected_terms]

  scope :open, -> { pending }

  before_save :generate_communication

  belongs_to :consultant, dependent: :destroy
  belongs_to :user, dependent: :destroy
  belongs_to :communication, class_name: 'Mailboxer::Conversation', inverse_of:
                                         :contact_conversation, dependent: :delete

  attr_accessor :message, :subject

  private

  def generate_communication
    convo = user.send_message(consultant, message, 'Contact Request').conversation
    self.communication_id = convo.id
  end
end
