class CustomerName < ActiveRecord::Base
  include Lookup

  DOS = { code: 'DOS', label: 'US Department of State' }
  USDT = { code: 'USDT', label: 'US Department of Treasury' }
  DOD = { code: 'DOD', label: 'US Department of Defense' }
  DOJ = { code: 'DOJ', label: 'US Department of Justice' }
  DOI = { code: 'DOI', label: 'US Department of Interior' }
  DOA = { code: 'DOA', label: 'US Department of Agriculture' }
  DOC = { code: 'DOC', label: 'US Department of Commerce' }
  DOL = { code: 'DOL', label: 'US Department of Labor' }
  DHHS = { code: 'DHHS', label: 'US Department of Health and Human Services' }
  HUD = { code: 'HUD', label: 'US Department of Housing and Urban Development' }
  DOT = { code: 'DOT', label: 'US Department of Transportation' }
  DOE = { code: 'DOE', label: 'US Department of Energy' }
  DOED = { code: 'DOED', label: 'US Department of Education' }
  DVA = { code: 'DVA', label: 'US Department of Veteran Affairs' }
  DHS = { code: 'DHS', label: 'US Department of Homeland Security' }
  INTEL = { code: 'INTEL', label: 'US Intelligence Community' }
  OMB = { code: 'OMB', label: 'Office of Management and Budget' }
  EPA = { code: 'EPA', label: 'Environmental Protection Agency' }
  SBA = { code: 'SBA', label: 'Small Business Administration' }
  CUSTOMER_NAME_TYPES = [DOS, USDT, DOD, DOJ, DOI, DOA, DOC, DOL, DHHS, HUD, DOT, DOE, DOED, DVA,
                         DHS, INTEL, OMB, EPA, SBA].freeze
end
