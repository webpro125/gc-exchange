class ClearanceLevel < ActiveRecord::Base
  include Lookup

  SECRET = { code: 'SECRET', label: 'Secret' }
  TS = { code: 'TS', label: 'Top Secret' }
  TSSCI = { code: 'TS/SCI', label: 'Top Secret/SCI' }

  CLEARANCE_LEVEL_TYPES = [SECRET, TS, TSSCI].freeze
end
