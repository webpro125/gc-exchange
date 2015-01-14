class Certification < ActiveRecord::Base
  include Lookup

  SIX_SIGMA                               = { code: 'SIX_SIGMA', label: 'Six Sigma' }
  PROFESSIONAL_ENGINEER_CIVIL             = { code: 'PROFESSIONAL_ENGINEER_CIVIL',
                                              label: 'Professional Engineer - Civil' }
  PROFESSIONAL_ENGINEER_MECHANICAL        = { code: 'PROFESSIONAL_ENGINEER_MECHANICAL',
                                              label: 'Professional Engineer - Mechanical' }
  PROFESSIONAL_ENGINEER_ELECTRICAL        = { code: 'PROFESSIONAL_ENGINEER_ELECTRICAL',
                                              label: 'Professional Engineer - Electrical' }
  PROFESSIONAL_ENGINEER_SYSTEMS           = { code: 'PROFESSIONAL_ENGINEER_SYSTEMS',
                                              label: 'Professional Engineer - Systems' }
  PMI_SCHEDULING_PROFESSIONAL             = { code: 'PMI_SCHEDULING_PROFESSIONAL',
                                              label: 'PMI Scheduling Professional' }
  PMI_AGILE_CERT_PRACTITIONER             = { code: 'PMI_AGILE_CERT_PRACTITIONER',
                                              label: 'PMI Agine Certification Practitioner' }
  PMI_RISK_PRACTITIONER                   = { code: 'PMI_RISK_PRACTITIONER',
                                              label: 'PMI Risk Practitioner' }
  PMI_PROJECT_MANAGER_PROFESSIONAL        = { code: 'PMI_PROJECT_MANAGER_PROFESSIONAL',
                                              label: 'PMI Project Manager Professional' }
  CERTIFIED_PROFESSIONAL_ACCOUNTANT       = { code: 'CERTIFIED_PROFESSIONAL_ACCOUNTANT',
                                              label: 'Certified Professional Accountant' }
  REGISTERED_ARCHITECT                    = { code: 'REGISTERED_ARCHITECT',
                                              label: 'Registered Architect' }
  KNOWLEDGE_MANAGER_PROFESSIONAL          = { code: 'KNOWLEDGE_MANAGER_PROFESSIONAL',
                                              label: 'Knowledge Manager Professional' }
  EMERGENCY_MANAGEMENT_PROFESSIONAL       = { code: 'EMERGENCY_MANAGEMENT_PROFESSIONAL',
                                              label: 'Emergency Management Professional' }
  CERTIFIED_ETHICAL_HACKER                = { code: 'CERTIFIED_ETHICAL_HACKER',
                                              label: 'Certified Ethical Hacker' }
  INFORMATION_SYSTEMS_AUDITOR             = { code: 'INFORMATION_SYSTEMS_AUDITOR',
                                              label: 'Information Systems Auditor' }
  LAWYER                                  = { code: 'LAWYER', label: 'Bar Certified Lawyer' }
  CERTIFIED_PROFESSIONAL_SYSTEMS_ENGINEER = { code: 'CERTIFIED_PROFESSIONAL_SYSTEMS_ENGINEER',
                                              label: 'Certified Professional Systems Engineer' }
  CERTIFIED_PROFESSIONAL_LOGISTICIAN      = { code: 'CERTIFIED_PROFESSIONAL_LOGISTICIAN',
                                              label: 'Certified Professional Logistician' }
  ITIL                                    = { code: 'IT_INFRASTRUCTURE_LIBRARY',
                                              label: 'Information Technology Infrastructure
Library (ITIL)' }
  CERTIFICATION_TYPES = [SIX_SIGMA, PROFESSIONAL_ENGINEER_CIVIL,
                         PROFESSIONAL_ENGINEER_MECHANICAL, PROFESSIONAL_ENGINEER_ELECTRICAL,
                         PROFESSIONAL_ENGINEER_SYSTEMS, PMI_SCHEDULING_PROFESSIONAL,
                         PMI_AGILE_CERT_PRACTITIONER, PMI_RISK_PRACTITIONER,
                         PMI_PROJECT_MANAGER_PROFESSIONAL, CERTIFIED_PROFESSIONAL_ACCOUNTANT,
                         REGISTERED_ARCHITECT, KNOWLEDGE_MANAGER_PROFESSIONAL,
                         EMERGENCY_MANAGEMENT_PROFESSIONAL, CERTIFIED_ETHICAL_HACKER,
                         INFORMATION_SYSTEMS_AUDITOR, LAWYER,
                         CERTIFIED_PROFESSIONAL_SYSTEMS_ENGINEER,
                         CERTIFIED_PROFESSIONAL_LOGISTICIAN, ITIL].freeze
end
