class Branch < ActiveRecord::Base
  USAF = 'USAF'
  USN = 'USN'
  USA = 'USA'
  USMC = 'USMC'
  USCG = 'USCG'

  BRANCH_TYPES = [USAF, USN, USA, USMC, USCG].freeze

  validates :code, length: { maximum: 10 }, uniqueness: true, presence: true
end
