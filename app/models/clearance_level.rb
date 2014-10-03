class ClearanceLevel < ActiveRecord::Base
  include Lookup

  SECRET = 'SECRET'
  TS = 'TS'
  TSSCI = 'TS/SCI'
  OTHER = 'OTHER'

  CLEARANCE_LEVEL_TYPES = [SECRET, TS, TSSCI, OTHER].freeze
end
