class ContactRequest < ActiveRecord::Base
  enum contact_status: [:pending, :interested, :not_interested, :hired, :not_pursuing,
                        :agreed_to_terms, :rejected_terms]

  scope :open, (lambda do
    where(arel_table[:contact_status].eq(0)
                                 .or(arel_table[:contact_status].eq(1))
                                 .or(arel_table[:contact_status].eq(3))
                                 .or(arel_table[:contact_status].eq(6)))
  end)

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
