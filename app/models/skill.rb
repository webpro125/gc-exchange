class Skill < ActiveRecord::Base
  SKILL_TYPES = [].freeze

  validates :code, length: { maximum: 128 }, uniqueness: { case_sensitive: false }, presence: true
end
