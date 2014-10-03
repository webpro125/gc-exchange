class Discipline < ActiveRecord::Base
  include Lookup

  SHIPLEY = 'SHIPLEY'
  SMA = 'SMA'
  OTHER = 'OTHER'

  DISCIPLINE_TYPES = [SHIPLEY, SMA, OTHER].freeze
end
