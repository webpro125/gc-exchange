class PhoneType < ActiveRecord::Base
  include Lookup

  HOME = { code: 'HOME', label: 'Home' }
  WORK = { code: 'WORK', label: 'Work' }
  CELL = { code: 'CELL', label: 'Cell' }

  PHONE_TYPES = [HOME, WORK, CELL].freeze

  scope :home, -> { find_by_code PhoneType::HOME[:code] }
  scope :work, -> { find_by_code PhoneType::WORK[:code] }
  scope :cell, -> { find_by_code PhoneType::CELL[:code] }

end
