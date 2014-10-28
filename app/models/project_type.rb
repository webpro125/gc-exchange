class ProjectType < ActiveRecord::Base
  include Lookup

  IT                           = 'IT'
  ACCOUNTING                   = 'ACCOUNTING'
  AGRICULTURE_FORESTRY_FISHING = 'AGRICULTURE_FORESTRY_FISHING'
  TELECOM                      = 'TELECOM'
  ELECTRONICS                  = 'ELECTRONICS'
  MECHANICAL                   = 'MECHANICAL'
  CIVIL                        = 'CIVIL'
  INDUSTRIAL                   = 'INDUSTRIAL'
  AEROSPACE                    = 'AEROSPACE'
  SERVICES                     = 'SERVICES'
  MANUFACTURING                = 'MANUFACTURING'
  LOGISTICS                    = 'LOGISTICS'
  TRAINING                     = 'TRAINING'
  WEAPON_SYSTEMS               = 'WEAPON_SYSTEMS'
  BIO_PHARM                    = 'BIO_PHARM'
  CONSTRUCTION                 = 'CONSTRUCTION'
  LEGAL                        = 'LEGAL'
  PRINTING_PUBLISHING          = 'PRINTING_PUBLISHING'
  SECURITY                     = 'SECURITY'
  TRANSPORTATION               = 'TRANSPORTATION'
  WASTE_MANAGEMENT             = 'WASTE_MANAGEMENT'
  NUCLEAR                      = 'NUCLEAR'
  HEALTH_MEDICAL               = 'HEALTH_MEDICAL'
  SOFTWARE                     = 'SOFTWARE'
  HARDWARE                     = 'HARDWARE'
  PROJECT_TYPE_TYPES = [IT, ACCOUNTING, AGRICULTURE_FORESTRY_FISHING, TELECOM, ELECTRONICS,
                        MECHANICAL, CIVIL, INDUSTRIAL, AEROSPACE, SERVICES, MANUFACTURING,
                        LOGISTICS, TRAINING, WEAPON_SYSTEMS, BIO_PHARM, CONSTRUCTION, LEGAL,
                        PRINTING_PUBLISHING, SECURITY, TRANSPORTATION, WASTE_MANAGEMENT, NUCLEAR,
                        HEALTH_MEDICAL, SOFTWARE, HARDWARE].freeze
end
