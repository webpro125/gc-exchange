class Project < ActiveRecord::Base
  enum contact_status: [:offered, :not_interested, :not_pursuing, :agreed_to_terms, :under_revision]

  scope :open,
        (lambda do
          where(arel_table[:contact_status].eq(Project.contact_statuses[:offered])
                  .or(arel_table[:contact_status].eq(
                        Project.contact_statuses[:under_revision]))
          ).order(:updated_at)
        end)

  belongs_to :travel_authorization
  belongs_to :consultant
  belongs_to :user

  validates :consultant, presence: true
  validates :user, presence: true
  validates :travel_authorization, presence: true
end
