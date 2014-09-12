class PhoneType < ActiveRecord::Base
  HOME = 'HOME'
  WORK = 'WORK'
  CELL = 'CELL'

  PHONE_TYPES = [HOME, WORK, CELL].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true, presence: true
end
