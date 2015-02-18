class Project < ActiveRecord::Base
  enum contact_status: [:hired, :not_interested, :not_pursuing, :agreed_to_terms, :rejected_terms]

  scope :open, (lambda do
    where(arel_table[:contact_status].eq(Project.contact_statuses[:hired])
                                 .or(arel_table[:contact_status].eq(
                                       Project.contact_statuses[:rejected_terms])))
  end)

  belongs_to :travel_authorization
  belongs_to :consultant
  belongs_to :user

  validates :consultant, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true
  validates :travel_authorization, presence: true
end
