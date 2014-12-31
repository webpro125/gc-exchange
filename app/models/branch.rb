class Branch < ActiveRecord::Base
  include Lookup

  USAF = { code: 'USAF', label: 'US Air Force' }
  USN = { code: 'USN', label: 'US Navy' }
  USA = { code: 'USA', label: 'US Army' }
  USMC = { code: 'USMC', label: 'US Marine Corps' }
  USCG = { code: 'USCG', label: 'US Coast Guard' }

  BRANCH_TYPES = [USAF, USN, USA, USMC, USCG].freeze
end
