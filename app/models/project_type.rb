class ProjectType < ActiveRecord::Base
  OTHER = 'OTHER'
  PROJECT_TYPE_TYPES = [OTHER].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true, presence: true
end
