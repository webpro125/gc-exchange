class PhoneType < ActiveRecord::Base
  include Lookup

  HOME = { code: 'HOME', label: 'Home Phone' }
  WORK = { code: 'WORK', label: 'Work Phone' }
  CELL = { code: 'CELL', label: 'Cell Phone' }

  PHONE_TYPES = [HOME, WORK, CELL].freeze
end
