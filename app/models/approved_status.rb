class ApprovedStatus < ActiveRecord::Base
  include Lookup

  PENDING_APPROVAL = 'PENDING_APPROVAL'
  IN_PROGRESS = 'IN_PROGRESS'
  APPROVED = 'APPROVED'
  REJECTED = 'REJECTED'

  APPROVED_STATUS_TYPES = [IN_PROGRESS, PENDING_APPROVAL, APPROVED, REJECTED].freeze
end
