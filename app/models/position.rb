class Position < ActiveRecord::Base
  POSITION_TYPES = [].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true
end
