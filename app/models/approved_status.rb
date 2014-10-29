class ApprovedStatus < ActiveRecord::Base
  include Lookup

  PENDING_APPROVAL = 'PENDING_APPROVAL'
  IN_PROGRESS = 'IN_PROGRESS'
  APPROVED = 'APPROVED'
  REJECTED = 'REJECTED'

  APPROVED_STATUS_TYPES = [IN_PROGRESS, PENDING_APPROVAL, APPROVED, REJECTED].freeze

  scope :approved, -> { @approved ||= find_by_code(APPROVED) }
  scope :rejected, -> { @rejected ||= find_by_code(REJECTED) }
  scope :in_progress, -> { @in_progress ||= find_by_code(IN_PROGRESS) }
  scope :pending_approval, -> { @pending_approval ||= find_by_code(PENDING_APPROVAL) }
end
