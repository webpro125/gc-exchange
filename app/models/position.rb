class Position < ActiveRecord::Base
  include Lookup

  CAPTURE_MANAGER         = { code: 'CAPTURE_MANAGER', label: 'Capture Manager', market_id: '1' }
  PROPOSAL_MANAGER        = { code: 'PROPOSAL_MANAGER', label: 'Proposal Manager', market_id: '1' }
  TECHNICAL_VOLUME        = { code: 'TECHNICAL_VOLUME', label: 'Technical Volume Lead', market_id: '1' }
  MANAGEMENT_VOLUME       = { code: 'MANAGEMENT_VOLUME', label: 'Management Volume Lead', market_id: '1' }
  COST_VOLUME             = { code: 'COST_VOLUME', label: 'Cost Volume Lead', market_id: '1' }
  SECURITY_VOLUME         = { code: 'SECURITY_VOLUME', label: 'Security Volume Lead', market_id: '1' }
  PAST_PERFORMANCE_VOLUME = { code: 'PAST_PERFORMANCE_VOLUME',
                              label: 'Past Performance Volume Lead', market_id: '1' }
  RESUME_VOLUME           = { code: 'RESUME_VOLUME', label: 'Resume Volume Lead', market_id: '1' }
  MANUFACTURING_VOLUME    = { code: 'MANUFACTURING_VOLUME', label: 'Manufacturing Volume Lead', market_id: '1' }
  PMI_IMF_SPECIALIST      = { code: 'PMI_IMF_SPECIALIST', label: 'Master Planner/Master Scheduler', market_id: '1' }
  PROGRAM_MANAGER         = { code: 'PROGRAM_MANAGER', label: 'Program Manager', market_id: '1' }
  CONTRACT_MANAGER        = { code: 'CONTRACT_MANAGER', label: 'Contract Manager', market_id: '1' }
  COST_ANALYST            = { code: 'COST_ANALYST', label: 'Cost Analyst', market_id: '1' }
  SOLUTION_ARCHITECT      = { code: 'SOLUTION_ARCHITECT', label: 'Solution Architect', market_id: '1' }
  SYSTEMS_ENGINEER        = { code: 'SYSTEMS_ENGINEER', label: 'Systems Engineer', market_id: '1' }
  PROGRAM_ARCHITECT       = { code: 'PROGRAM_ARCHITECT', label: 'Program Architect', market_id: '1' }
  BUSINESS_ARCHITECT      = { code: 'BUSINESS_ARCHITECT', label: 'Business Architect', market_id: '1' }
  PRODUCTION_MANAGER      = { code: 'PRODUCTION_MANAGER', label: 'Production Manager/Coordinator', market_id: '1' }
  TECHNICAL_EDITOR        = { code: 'TECHNICAL_EDITOR', label: 'Technical Editor', market_id: '1' }
  DESKTOP_PUBLISHER       = { code: 'DESKTOP_PUBLISHER', label: 'Desktop Publisher', market_id: '1' }
  GRAPHIC_DEVELOPER       = { code: 'GRAPHIC_DEVELOPER', label: 'Graphic Artist/Developer', market_id: '1' }
  WIN_STRATEGY_LEAD       = { code: 'WIN_STRATEGY_LEAD', label: 'Win Strategy Lead', market_id: '1' }
  PROPOSAL_COORDINATOR    = { code: 'PROPOSAL_COORDINATOR', label: 'Proposal Coordinator', market_id: '1' }
  PRICE_TO_WIN_ANALYST    = { code: 'PRICE_TO_WIN_ANALYST', label: 'Price to win Analyst', market_id: '1' }
  COLOR_REVIEW            = { code: 'COLOR_REVIEW', label: 'Color Review', market_id: '1' }
  MENTOR                  = { code: 'MENTOR', label: 'Mentor', market_id: '1' }
  PROPOSAL_WRITER         = { code: 'PROPOSAL_WRITER', label: 'Proposal Writer', market_id: '1' }
  ORALS_SPECALIST         = { code: 'ORALS_SPECALIST', label: 'Orals Specialist', market_id: '1' }
  LEGAL_COUNSEL           = { code: 'LEGAL_COUNSEL', label: 'Legal Counsel', market_id: '1' }
  BUSINESS_STRATEGY_DEV   = { code: 'BUSINESS_STRATEGY_DEV', label: 'Business Strategy Development', market_id: '1'}
  BUSINESS_OPP_PIPE_DEV   = { code: 'BUSINESS_OPP_PIPE_DEV', label: 'Business Opportunity Pipeline Development', market_id: '1'}
  CONCEPT_OPS_DEV         = { code: 'CONCEPT_OPS_DEV', label: 'Concept of Operations Development', market_id: '1'}
  MAINTENANCE_MGMT        = { code: 'MAINTENANCE_MGMT', label: 'Maintenance Management', market_id: '1'}
  ORALS_COACH             = { code: 'ORALS_COACH', label: 'Orals Coach', market_id: '1'}
  QUALITY_MGMT            = { code: 'QUALITY_MGMT', label: 'Quality Management', market_id: '1'}
  RISK_MGMT               = { code: 'RISK_MGMT', label: 'Risk Management', market_id: '1'}
  SUBJECT_MATTER_EXPERT   = { code: 'SUBJECT_MATTER_EXPERT', label: 'Subject Matter Expert', market_id: '1'}
  TRAINING_MGMT           = { code: 'TRAINING_MGMT', label: 'Training Management', market_id: '1'}
  OTHER                   = { code: 'OTHER', label: 'Other', market_id: '1'}
  BUSINESS_DEV_SALES_FUN  = { code: 'BUSINESS_DEV_SALES_FUN', label: 'Business Development/Sales Functions', market_id: '2'}
  COMMAND_AND_CONTROL     = { code: 'COMMAND_AND_CONTROL', label: 'Command and Control', market_id: '2'}
  CONTRACTS_AND_PROCURMENT= { code: 'CONTRACTS_AND_PROCURMENT', label: 'Contracts and Procurement (Includes Insurance)', market_id: '2'}
  ED_AND_TRAINING         = { code: 'ED_AND_TRAINING', label: 'Education & Training', market_id: '2'}
  FACILITIES_MAINT_MGMT   = { code: 'FACILITIES_MAINT_MGMT', label: 'Facilities Maintenance & Management', market_id: '2'}
  FINANCE_AND_ACCT        = { code: 'FINANCE_AND_ACCT', label: 'Finance and Accounting', market_id: '2'}
  GENERAL_MGMT_ADMIN      = { code: 'GENERAL_MGMT_ADMIN', label: 'General Management and Administration', market_id: '2'}
  HEALTH_SERVICES         = { code: 'HEALTH_SERVICES', label: 'Health Services', market_id: '2'}
  HR                      = { code: 'HR', label: 'Human Resources, Personnel, Benefits, Training', market_id: '2'}
  IT                      = { code: 'IT', label: 'Information Technology', market_id: '2'}
  INTEL_RECON_SURVEIL     = { code: 'INTEL_RECON_SURVEIL', label: 'Interlligence, Reconnaissance, and Surveillance', market_id: '2'}
  LEADERSHIP              = { code: 'LEADERSHIP', label: 'Leadership', market_id: '2'}
  LEGAL_SERVICES          = { code: 'LEGAL_SERVICES', label: 'Legal Services', market_id: '2'}
  MARKETING_COM_PR        = { code: 'MARKETING_COM_PR', label: 'Marketing, Communications, Public Relations', market_id: '2'}
  PROGRAM_PROJECT_MGMT    = { code: 'PROGRAM_PROJECT_MGMT', label: 'Program or Project Management', market_id: '2'}
  ORG_LEADERSHIP          = { code: 'ORG_LEADERSHIP', label: 'Organizational Leadership', market_id: '2'}
  QUALITY_MGMT2            = { code: 'QUALITY_MGMT', label: 'Quality Management', market_id: '2'}
  SCIENCE_ENG             = { code: 'SCIENCE_ENG', label: 'Science & Engineering', market_id: '2'}
  SUBJECT_MATTER_EXPERT2   = { code: 'SUBJECT_MATTER_EXPERT', label: 'Subject Matter Expert', market_id: '2'}
  SUPERVISION             = { code: 'SUPERVISION', label: 'Supervision', market_id: '2'}
  SECUTIRY_SERVICES       = { code: 'SECUTIRY_SERVICES', label: 'Security Services', market_id: '2'}
  TRANSPORT_LOGISITICS    = { code: 'TRANSPORT_LOGISITICS', label: 'Transportation & Logistics Operations and Support', market_id: '2'}
  OTHER2                   = { code: 'OTHER', label: 'Other', market_id: '2'}

  POSITION_TYPES = [CAPTURE_MANAGER, PROPOSAL_MANAGER, TECHNICAL_VOLUME, MANAGEMENT_VOLUME,
                    RESUME_VOLUME, SECURITY_VOLUME, COST_VOLUME, PAST_PERFORMANCE_VOLUME,
                    MANUFACTURING_VOLUME, PMI_IMF_SPECIALIST, PROGRAM_MANAGER, CONTRACT_MANAGER,
                    COST_ANALYST, SOLUTION_ARCHITECT, SYSTEMS_ENGINEER, PROGRAM_ARCHITECT,
                    BUSINESS_ARCHITECT, TECHNICAL_EDITOR, GRAPHIC_DEVELOPER, PRODUCTION_MANAGER,
                    WIN_STRATEGY_LEAD, PROPOSAL_COORDINATOR, MENTOR, PRICE_TO_WIN_ANALYST,
                    COLOR_REVIEW, DESKTOP_PUBLISHER, PROPOSAL_WRITER, ORALS_SPECALIST,
                    LEGAL_COUNSEL, BUSINESS_STRATEGY_DEV, BUSINESS_OPP_PIPE_DEV, CONCEPT_OPS_DEV, MAINTENANCE_MGMT, ORALS_COACH, QUALITY_MGMT, RISK_MGMT, SUBJECT_MATTER_EXPERT, TRAINING_MGMT, OTHER,
                    BUSINESS_DEV_SALES_FUN, COMMAND_AND_CONTROL, CONTRACTS_AND_PROCURMENT, ED_AND_TRAINING, FACILITIES_MAINT_MGMT, FINANCE_AND_ACCT, GENERAL_MGMT_ADMIN, HEALTH_SERVICES, HR, IT, INTEL_RECON_SURVEIL, LEADERSHIP, LEGAL_SERVICES, MARKETING_COM_PR, PROGRAM_PROJECT_MGMT, ORG_LEADERSHIP, QUALITY_MGMT2, SCIENCE_ENG, SUBJECT_MATTER_EXPERT2, SUPERVISION, SECUTIRY_SERVICES, TRANSPORT_LOGISITICS, OTHER2].freeze
end
