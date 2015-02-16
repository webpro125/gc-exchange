class ContactRequest < ActiveRecord::Base
  enum contact_status: { pending: 0, interested: 1, not_interested: 2, hired: 3, not_pursuing: 4,
                         agreed_to_terms: 5, rejected_terms: 6 }

  scope :open, (lambda do
    where(arel_table[:contact_status].eq(ContactRequest.contact_statuses[:pending])
                                 .or(arel_table[:contact_status].eq(
                                       ContactRequest.contact_statuses[:interested]))
                                 .or(arel_table[:contact_status].eq(
                                       ContactRequest.contact_statuses[:hired]))
                                 .or(arel_table[:contact_status].eq(
                                       ContactRequest.contact_statuses[:rejected_terms])))
  end)

  before_create :generate_communication

  has_one :travel_authorization
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
