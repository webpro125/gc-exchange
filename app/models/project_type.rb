class ProjectType < ActiveRecord::Base
  include Lookup

  IT                           = { code: 'IT', label: 'Information Technology' }
  ACCOUNTING                   = { code: 'ACCOUNTING', label: 'Financial and Accounting' }
  AGRICULTURE_FORESTRY_FISHING = { code: 'AGRICULTURE_FORESTRY_FISHING',
                                   label: 'Agriculture/Forestry/Fishing' }
  TELECOM                      = { code: 'TELECOM', label: 'Telecommunications' }
  ELECTRONICS                  = { code: 'ELECTRONICS', label: 'Electronics' }
  MECHANICAL                   = { code: 'MECHANICAL', label: 'Mechanical' }
  CIVIL                        = { code: 'CIVIL', label: 'Civil' }
  INDUSTRIAL                   = { code: 'INDUSTRIAL',
                                   label: 'Industrial Facilities and Infrastructure' }
  AEROSPACE                    = { code: 'AEROSPACE', label: 'Aerospace and Defense' }
  SERVICES                     = { code: 'SERVICES', label: 'Other Business Support Services' }
  MANUFACTURING                = { code: 'MANUFACTURING', label: 'Manufacturing' }
  LOGISTICS                    = { code: 'LOGISTICS', label: 'Logistics' }
  TRAINING                     = { code: 'TRAINING', label: 'Training' }
  WEAPON_SYSTEMS               = { code: 'WEAPON_SYSTEMS', label: 'Weapon Systems' }
  BIO_PHARM                    = { code: 'BIO_PHARM', label: 'Biotechnology/Pharmaceuticals' }
  CONSTRUCTION                 = { code: 'CONSTRUCTION', label: 'Construction' }
  LEGAL                        = { code: 'LEGAL', label: 'Legal Services' }
  PRINTING_PUBLISHING          = { code: 'PRINTING_PUBLISHING',
                                   label: 'Printing and Publishing Services' }
  SECURITY                     = { code: 'SECURITY', label: 'Security and Surveillance' }
  TRANSPORTATION               = { code: 'TRANSPORTATION', label: 'Transportation and Storage' }
  WASTE_MANAGEMENT             = { code: 'WASTE_MANAGEMENT', label: 'Waste Management' }
  NUCLEAR                      = { code: 'NUCLEAR', label: 'Nuclear' }
  HEALTH_MEDICAL               = { code: 'HEALTH_MEDICAL', label: 'Health and Medical' }
  SOFTWARE                     = { code: 'SOFTWARE', label: 'Computer - Software' }
  HARDWARE                     = { code: 'HARDWARE', label: 'Computer - Hardware' }
  PROJECT_TYPE_TYPES = [IT, ACCOUNTING, AGRICULTURE_FORESTRY_FISHING, TELECOM, ELECTRONICS,
                        MECHANICAL, CIVIL, INDUSTRIAL, AEROSPACE, SERVICES, MANUFACTURING,
                        LOGISTICS, TRAINING, WEAPON_SYSTEMS, BIO_PHARM, CONSTRUCTION, LEGAL,
                        PRINTING_PUBLISHING, SECURITY, TRANSPORTATION, WASTE_MANAGEMENT, NUCLEAR,
                        HEALTH_MEDICAL, SOFTWARE, HARDWARE].freeze
end
