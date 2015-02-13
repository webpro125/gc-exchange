class ContactRequest < ActiveRecord::Base
  enum contact_status: [:pending, :interested, :not_interested, :hired, :not_pursuing,
                        :agreed_to_terms, :rejected_terms]

  scope :open, -> { pending | interested | hired | rejected_terms }

  before_save :generate_communication

  belongs_to :consultant
  belongs_to :user
  belongs_to :communication, class_name: 'Mailboxer::Conversation', dependent: :destroy

  attr_accessor :message, :subject

  private

  def generate_communication
    self.communication_id = user.send_message(consultant, message,
                                              'Contact Request').conversation.id
  end
end
