class ProjectType < ActiveRecord::Base
  PROJECT_TYPE = [].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true, presence: true
end
