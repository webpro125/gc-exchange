class Skill < ActiveRecord::Base
  SKILL_TYPES = [].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true
end
