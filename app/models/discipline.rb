class Discipline < ActiveRecord::Base
  SHIPLEY = 'SHIPLEY'
  SMA = 'SMA'
  OTHER = 'OTHER'

  DISCIPLINE_TYPES = [SHIPLEY, SMA, OTHER].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true, presence: true
end
