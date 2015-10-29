class Markets < ActiveRecord::Base
  include Lookup

  GOV_CONSULTANT = { code: 'GOV_CONSULTANT', label: 'Government Contractor - Business Capture Experience', market_id: '1'}
  GOV_COMMERCIAL = { code:'GOV_COMMERCIAL', label: 'Government & Non-government Experience', market_id: '2'}

  MARKETS = [GOV_CONSULTANT, GOV_COMMERCIAL].freeze
  
end
