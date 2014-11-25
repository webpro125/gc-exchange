class PhoneType < ActiveRecord::Base
  include Lookup

  HOME = { code: 'HOME', label: 'Home' }
  WORK = { code: 'WORK', label: 'Work' }
  CELL = { code: 'CELL', label: 'Cell' }

  PHONE_TYPES = [HOME, WORK, CELL].freeze
end
