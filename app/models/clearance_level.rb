class ClearanceLevel < ActiveRecord::Base

  SECRET = 'SECRET'
  TS = 'TS'
  TSSCI = 'TS/SCI'

  CLEARANCE_TYPES = [SECRET, TS, TSSCI].freeze
  validates :code, length: { maximum: 10 }, uniqueness: true
end
