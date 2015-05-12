class Position < ActiveRecord::Base
  include Lookup

  CAPTURE_MANAGER         = { code: 'CAPTURE_MANAGER', label: 'Capture Manager' }
  PROPOSAL_MANAGER        = { code: 'PROPOSAL_MANAGER', label: 'Proposal Manager' }
  TECHNICAL_VOLUME        = { code: 'TECHNICAL_VOLUME', label: 'Technical Volume Lead' }
  MANAGEMENT_VOLUME       = { code: 'MANAGEMENT_VOLUME', label: 'Management Volume Lead' }
  COST_VOLUME             = { code: 'COST_VOLUME', label: 'Cost Volume Lead' }
  SECURITY_VOLUME         = { code: 'SECURITY_VOLUME', label: 'Security Volume Lead' }
  PAST_PERFORMANCE_VOLUME = { code: 'PAST_PERFORMANCE_VOLUME',
                              label: 'Past Performance Volume Lead' }
  RESUME_VOLUME           = { code: 'RESUME_VOLUME', label: 'Resume Volume Lead' }
  MANUFACTURING_VOLUME    = { code: 'MANUFACTURING_VOLUME', label: 'Manufacturing Volume Lead' }
  PMI_IMF_SPECIALIST      = { code: 'PMI_IMF_SPECIALIST', label: 'Master Planner/Master Scheduler' }
  PROGRAM_MANAGER         = { code: 'PROGRAM_MANAGER', label: 'Program Manager' }
  CONTRACT_MANAGER        = { code: 'CONTRACT_MANAGER', label: 'Contract Manager' }
  COST_ANALYST            = { code: 'COST_ANALYST', label: 'Cost Analyst' }
  SOLUTION_ARCHITECT      = { code: 'SOLUTION_ARCHITECT', label: 'Solution Architect' }
  SYSTEMS_ENGINEER        = { code: 'SYSTEMS_ENGINEER', label: 'Systems Engineer' }
  PROGRAM_ARCHITECT       = { code: 'PROGRAM_ARCHITECT', label: 'Program Architect' }
  BUSINESS_ARCHITECT      = { code: 'BUSINESS_ARCHITECT', label: 'Business Architect' }
  PRODUCTION_MANAGER      = { code: 'PRODUCTION_MANAGER', label: 'Production Manager/Coordinator' }
  TECHNICAL_EDITOR        = { code: 'TECHNICAL_EDITOR', label: 'Technical Editor' }
  DESKTOP_PUBLISHER       = { code: 'DESKTOP_PUBLISHER', label: 'Desktop Publisher' }
  GRAPHIC_DEVELOPER       = { code: 'GRAPHIC_DEVELOPER', label: 'Graphic Artist/Developer' }
  WIN_STRATEGY_LEAD       = { code: 'WIN_STRATEGY_LEAD', label: 'Win Strategy Lead' }
  PROPOSAL_COORDINATOR    = { code: 'PROPOSAL_COORDINATOR', label: 'Proposal Coordinator' }
  PRICE_TO_WIN_ANALYST    = { code: 'PRICE_TO_WIN_ANALYST', label: 'Price to win Analyst' }
  COLOR_REVIEW            = { code: 'COLOR_REVIEW', label: 'Color Review' }
  MENTOR                  = { code: 'MENTOR', label: 'Mentor' }
  PROPOSAL_WRITER         = { code: 'PROPOSAL_WRITER', label: 'Proposal Writer' }
  ORALS_SPECALIST         = { code: 'ORALS_SPECALIST', label: 'Orals Specialist' }
  LEGAL_COUNSEL           = { code: 'LEGAL_COUNSEL', label: 'Legal Counsel' }

  POSITION_TYPES = [CAPTURE_MANAGER, PROPOSAL_MANAGER, TECHNICAL_VOLUME, MANAGEMENT_VOLUME,
                    RESUME_VOLUME, SECURITY_VOLUME, COST_VOLUME, PAST_PERFORMANCE_VOLUME,
                    MANUFACTURING_VOLUME, PMI_IMF_SPECIALIST, PROGRAM_MANAGER, CONTRACT_MANAGER,
                    COST_ANALYST, SOLUTION_ARCHITECT, SYSTEMS_ENGINEER, PROGRAM_ARCHITECT,
                    BUSINESS_ARCHITECT, TECHNICAL_EDITOR, GRAPHIC_DEVELOPER, PRODUCTION_MANAGER,
                    WIN_STRATEGY_LEAD, PROPOSAL_COORDINATOR, MENTOR, PRICE_TO_WIN_ANALYST,
                    COLOR_REVIEW, DESKTOP_PUBLISHER, PROPOSAL_WRITER, ORALS_SPECALIST,
                    LEGAL_COUNSEL].freeze
end
