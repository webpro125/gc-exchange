class ClearanceLevel < ActiveRecord::Base
  include Lookup

  SECRET = { code: 'SECRET', label: 'Secret' }
  TS = { code: 'TS', label: 'Top Secret' }
  TSSCI = { code: 'TS/SCI', label: 'Top Secret/SCI' }

  CLEARANCE_LEVEL_TYPES = [SECRET, TS, TSSCI].freeze

  scope :secret, -> { find_by_code ClearanceLevel::SECRET[:code] }
  scope :ts, -> { find_by_code ClearanceLevel::TS[:code] }
  scope :ts_sci, -> { find_by_code ClearanceLevel::TSSCI[:code] }
end
