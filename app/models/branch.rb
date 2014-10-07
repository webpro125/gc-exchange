class Branch < ActiveRecord::Base
  include Lookup

  USAF = 'USAF'
  USN = 'USN'
  USA = 'USA'
  USMC = 'USMC'
  USCG = 'USCG'

  BRANCH_TYPES = [USAF, USN, USA, USMC, USCG].freeze
end
