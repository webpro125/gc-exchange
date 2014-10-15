class Certification < ActiveRecord::Base
  include Lookup

  CERTIFICATION_TYPES = [].freeze
end
