class ClearanceLevel < ActiveRecord::Base
  SECRET = 'SECRET'
  TS = 'TS'
  TSSCI = 'TS/SCI'
  OTHER = 'OTHER'

  CLEARANCE_LEVEL_TYPES = [SECRET, TS, TSSCI, OTHER].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true, presence: true
end
