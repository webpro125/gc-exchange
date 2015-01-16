class ApprovedStatus < ActiveRecord::Base
  include Lookup

  ON_HOLD = { code: 'ON_HOLD', label: 'On Hold' }
  PENDING_APPROVAL = { code: 'PENDING_APPROVAL', label: 'Pending Approval' }
  IN_PROGRESS = { code: 'IN_PROGRESS', label: 'In Progress' }
  APPROVED = { code: 'APPROVED', label: 'Approved' }
  REJECTED = { code: 'REJECTED', label: 'Rejected' }

  APPROVED_STATUS_TYPES = [IN_PROGRESS, PENDING_APPROVAL, ON_HOLD, APPROVED,
                           REJECTED].freeze

  scope :approved, -> { find_by_code(APPROVED[:code]) }
  scope :rejected, -> { find_by_code(REJECTED[:code]) }
  scope :in_progress, -> { find_by_code(IN_PROGRESS[:code]) }
  scope :pending_approval, -> { find_by_code(PENDING_APPROVAL[:code]) }
  scope :on_hold, -> { find_by_code(ON_HOLD[:code]) }
end
