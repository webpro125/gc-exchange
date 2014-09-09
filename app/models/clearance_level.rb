class ClearanceLevel < ActiveRecord::Base

  CLEARANCE_TYPES = [].freeze
  validates :code, length: { maximum: 10 }, uniqueness: true
end
