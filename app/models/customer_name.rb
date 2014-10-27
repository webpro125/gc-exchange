class CustomerName < ActiveRecord::Base
  include Lookup

  DOS = 'DOS'
  USDT = 'USDT'
  DOD = 'DOD'
  DOJ = 'DOJ'
  DOI = 'DOI'
  DOA = 'DOA'
  DOC = 'DOC'
  DOL = 'DOL'
  DHHS = 'DHHS'
  HUD = 'HUD'
  DOT = 'DOT'
  DOE = 'DOE'
  DOED = 'DOED'
  DVA = 'DVA'
  DHS = 'DHS'
  INTEL = 'INTEL'
  OMB = 'OMB'
  EPA = 'EPA'
  SBA = 'SBA'
  CUSTOMER_NAME_TYPES = [DOS, USDT, DOD, DOJ, DOI, DOA, DOC, DOL, DHHS, HUD, DOT, DOE, DOED, DVA,
                         DHS, INTEL, OMB, EPA, SBA].freeze
end
