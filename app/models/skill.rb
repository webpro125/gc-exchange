class Skill < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  SKILL_TYPES = ['Accounting', 'Advertisement', 'Aerospace Engineering', 'Agile Development',
                 'Android', 'Artificial Intelligence', 'Availability Management', 'Big Data',
                 'Business Architecture', 'Business Development', 'Business Process Re-engineering',
                 'C++', 'Capability Maturity Model Integration', 'Change Management',
                 'Circuit Management', 'Cloud Computing', 'Communication Management',
                 'Computer Aided Design', 'Configuration Management', 'Contract Law',
                 'Contractor Performance Assessment Reporting System',
                 'Control Objectives for Information and Related Technology', 'Critical Path',
                 'Customer Relationship Management', 'Cyber Security', 'Data Visualization',
                 'Database Administration', 'Defense Federal Acquisition Regulation Supplement',
                 'Earned Value Management', 'Economics', 'Enterprise Architecture',
                 'Federal Acquisition Regulation', 'Finance Management', 'Fluid Mechanics',
                 'Industrial Engineering', 'Information Security',
                 'Information Technology Infrastructure Library', 'Integrated Master Planning',
                 'International Organization for Standardization', 'iOS', 'Java', 'JavaScript',
                 'Knowledge Management', 'Lean Six Sigma', 'Linux', 'Logistics Management',
                 'Machine to Machine Technologies', 'Maintainability Management',
                 'Marketing and Sales Management', 'Mechanical Engineering',
                 'Mission Systems Analysis', 'Mobile Device Management', 'Modeling and Simulation',
                 'MongoDB', 'MS Project', 'MySQL', 'Network Architecture', 'Network Security',
                 'Nuclear Engineering', 'Organization Change Management', 'PHP',
                 'Portfolio Management', 'PostgreSQL', 'Primavera', 'Problem Management',
                 'Process Engineering', 'Program Management', 'Project Management',
                 'Project Management Body of Knowledge', 'Propulsion Systems', 'Public Affairs',
                 'Python', 'Quality Management', 'Reliability Management',
                 'Requirements Management', 'Risk Management', 'Ruby', 'Satellite Systems',
                 'Schedule Management', 'Scrum Software Development', 'Server Administration',
                 'Social Media', 'Software Engineering', 'Solid Works', 'Specialty Engineering',
                 'SQL', 'Storage Administration', 'Strategy Management', 'Systems Engineering',
                 'Talent Management', 'Telecommunications', 'Telemetry', 'Test Management',
                 'Thermodynamics', 'Training Management', 'Transportation Management',
                 'Unified Communications', 'Unix', 'Urban Planning', 'Value Delivery System',
                 'Value Proposition', 'Weapons Systems', 'XML'].freeze

  before_create :lower_code

  validates :code, length: { maximum: 128 }, uniqueness: { case_sensitive: false }, presence: true

  def self.search(query)
    __elasticsearch__.search query: { fuzzy: { code: query } }
  end

  private

  def lower_code
    code.downcase!
  end
end
