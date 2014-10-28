class Position < ActiveRecord::Base
  include Lookup

  CAPTURE_MANAGER         = 'CAPTURE_MANAGER'
  PROPOSAL_MANAGER        = 'PROPOSAL_MANAGER'
  TECHNICAL_VOLUME        = 'TECHNICAL_VOLUME'
  MANAGEMENT_VOLUME       = 'MANAGEMENT_VOLUME'
  COST_VOLUME             = 'COST_VOLUME'
  SECURITY_VOLUME         = 'SECURITY_VOLUME'
  PAST_PERFORMANCE_VOLUME = 'PAST_PERFORMANCE_VOLUME'
  RESUME_VOLUME           = 'RESUME_VOLUME'
  MANUFACTURING_VOLUME    = 'MANUFACTURING_VOLUME'
  PMI_IMF_SPECIALIST      = 'PMI_IMF_SPECIALIST'
  PROGRAM_MANAGER         = 'PROGRAM_MANAGER'
  CONTRACT_MANAGER        = 'CONTRACT_MANAGER'
  COST_ANALYST            = 'COST_ANALYST'
  SOLUTION_ARCHITECT      = 'SOLUTION_ARCHITECT'
  SYSTEMS_ENGINEER        = 'SYSTEMS_ENGINEER'
  PROGRAM_ARCHITECT       = 'PROGRAM_ARCHITECT'
  BUSINESS_ARCHITECT      = 'BUSINESS_ARCHITECT'
  PRODUCTION_MANAGER      = 'PRODUCTION_MANAGER'
  TECHNICAL_EDITOR        = 'TECHNICAL_EDITOR'
  DESKTOP_PUBLISHER       = 'DESKTOP_PUBLISHER'
  GRAPHIC_DEVELOPER       = 'GRAPHIC_DEVELOPER'
  WIN_STRATEGY_LEAD       = 'WIN_STRATEGY_LEAD'
  PROPOSAL_COORDINATOR    = 'PROPOSAL_COORDINATOR'
  PRICE_TO_WIN_ANALYST    = 'PRICE_TO_WIN_ANALYST'

  POSITION_TYPES = [CAPTURE_MANAGER, PROPOSAL_MANAGER, TECHNICAL_VOLUME, MANAGEMENT_VOLUME,
                    RESUME_VOLUME, SECURITY_VOLUME, COST_VOLUME, PAST_PERFORMANCE_VOLUME,
                    MANUFACTURING_VOLUME, PMI_IMF_SPECIALIST, PROGRAM_MANAGER, CONTRACT_MANAGER,
                    COST_ANALYST, SOLUTION_ARCHITECT, SYSTEMS_ENGINEER, PROGRAM_ARCHITECT,
                    BUSINESS_ARCHITECT, TECHNICAL_EDITOR, GRAPHIC_DEVELOPER, PRODUCTION_MANAGER,
                    WIN_STRATEGY_LEAD, PROPOSAL_COORDINATOR, PRICE_TO_WIN_ANALYST,
                    DESKTOP_PUBLISHER].freeze
end
