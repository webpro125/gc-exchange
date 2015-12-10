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
  JCOS = { code: 'JCOS', label: 'Joint Chiefs of Staff' }
  ARMY = { code: 'ARMY', label: 'United States Army' }
  NAVY = { code: 'NAVY', label: 'United States Navy' }
  AIRFORCE = { code: 'AIRFORCE', label: 'United States Air Force' }
  MARINE = { code: 'MC', label: 'United States Marine Corps' }
  NORTHCOM = { code: 'NORTHCOM', label: 'US Northern Command' }
  SOUTHCOM = { code: 'SOUTHCOM', label: 'US Southern Command' }
  CENTCOM = { code: 'CENTCOM', label: 'US Central Command' }
  EUCOM = { code: 'EUCOM', label: 'US European Command' }
  PACOM = { code: 'PACOM', label: 'US Pacific Command' }
  AFRICOM = { code: 'AFRICOM', label: 'US Africa Command' }
  STRATCOM = { code: 'STRATCOM', label: 'US Strategic Command' }
  SOCOM = { code: 'SOCOM', label: 'US Special Operations Command' }
  TRANSCOM = { code: 'TRANSCOM', label: 'US Transportation Command' }
  COAST = { code: 'COAST', label: 'US Coast Guard' }
  ODNI = { code: 'ODNI', label: 'Office of the Director of National Intelligence' }
  CIA = { code: 'CIA', label: 'Central Intelligence Agency' }
  CGI = { code: 'CGI', label: 'Coast Guard Intelligence' }
  HSI = { code: 'HSI', label: 'Homeland Security Investigations' }
  INR = { code: 'INR', label: 'Bureau of Intelligence and Research' }
  TFI = { code: 'TFI', label: 'Office of Terrorism and Financial Intelligence' }
  DIA = { code: 'DIA', label: 'Defense Intelligence Agency' }
  NSA = { code: 'NSA', label: 'National Security Agency' }
  NGA = { code: 'NGA', label: 'National Geospatial-Intelligence Agency' }
  NRO = { code: 'NRO', label: 'National Reconnaissance Office' }
  CYBERCOM = { code: 'CYBERCOM', label: 'US Cyber Command' }
  AFISRA = { code:  'AFISRA',
             label: 'Air Force Intelligence, Surveillance and Reconnaissance Agency' }
  NASIC = { code: 'NASIC', label: 'National Air and Space Intelligence Center' }
  INSCOM = { code: 'INSCOM', label: 'United States Army Intelligence and Security Command' }
  NGIC = { code: 'NGIC', label: 'National Ground Intelligence Center' }
  MCIA = { code: 'MCIA', label: 'Marine Corpse Intelligence Activity' }
  ONI = { code: 'ONI', label: 'Office of Naval Intelligence' }
  FBI = { code: 'FBI', label: 'Federal Bureau of Investigation, National Security Branch' }
  DEA = { code:  'DEA',
          label: 'Drug Enforcement Administration, Office of National Security Intelligence' }
  FDIC = { code: 'FDIC', label: 'Federal Deposit Insurance Corporation' }
  CUSTOMER_NAME_TYPES = [DOS, USDT, DOD, DOJ, DOI, DOA, DOC, DOL, DHHS, HUD, DOT, DOE, DOED, DVA,
                         DHS, INTEL, OMB, EPA, SBA, JCOS, ARMY, NAVY, AIRFORCE, MARINE, NORTHCOM,
                         SOUTHCOM, CENTCOM, EUCOM, PACOM, AFRICOM, STRATCOM, SOCOM, TRANSCOM, COAST,
                         ODNI, CIA, CGI, HSI, INR, TFI, DIA, NSA, NGA, NRO, CYBERCOM, AFISRA,
                         NASIC, INSCOM, NGIC, MCIA, ONI, FBI, DEA, FDIC].freeze
end
