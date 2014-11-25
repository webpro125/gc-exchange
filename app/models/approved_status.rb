class ApprovedStatus < ActiveRecord::Base
  include Lookup

  PENDING_APPROVAL = { code: 'PENDING_APPROVAL', label: 'Pending Approval' }
  IN_PROGRESS = { code: 'IN_PROGRESS', label: 'In Progress' }
  APPROVED = { code: 'APPROVED', label: 'Approved' }
  REJECTED = { code: 'REJECTED', label: 'Rejected' }

  APPROVED_STATUS_TYPES = [IN_PROGRESS, PENDING_APPROVAL, APPROVED, REJECTED].freeze

  scope :approved, -> { @approved ||= find_by_code(APPROVED[:code]) }
  scope :rejected, -> { @rejected ||= find_by_code(REJECTED[:code]) }
  scope :in_progress, -> { @in_progress ||= find_by_code(IN_PROGRESS[:code]) }
  scope :pending_approval, -> { @pending_approval ||= find_by_code(PENDING_APPROVAL[:code]) }
end
