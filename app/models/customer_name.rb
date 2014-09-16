class CustomerName < ActiveRecord::Base
  NASA = 'NASA'
  USTD = 'USTD'
  DOS = 'DOS'
  FBI = 'FBI'
  DOA = 'DOA'
  DOI = 'DOI'
  DOT = 'DOT'
  DOE = 'DOE'
  DHS = 'DHS'
  CIA = 'CIA'
  NSA = 'NSA'
  DOD = 'DOD'
  DIA = 'DIA'
  HHS = 'HHS'
  HUD = 'HUD'
  EPA = 'EPA'
  USPS = 'USPS'
  OTHER_FED = 'OTHER_FED'
  OTHER_STATE = 'OTHER_STATE'
  CUSTOMER_NAME_TYPES = [NASA, USTD, DOS, FBI, DOA, DOI, DOT, DOE, DHS, CIA, NSA, DOD, DIA,
                         HHS, HUD, EPA, USPS, OTHER_FED, OTHER_STATE].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true, presence: true
end
