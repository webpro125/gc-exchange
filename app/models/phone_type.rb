class PhoneType < ActiveRecord::Base
  include Lookup

  HOME = 'HOME'
  WORK = 'WORK'
  CELL = 'CELL'

  PHONE_TYPES = [HOME, WORK, CELL].freeze
end
