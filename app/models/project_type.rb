class ProjectType < ActiveRecord::Base
  include Lookup

  OTHER = 'OTHER'
  PROJECT_TYPE_TYPES = [OTHER].freeze
end
