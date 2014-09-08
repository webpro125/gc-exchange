class Discipline < ActiveRecord::Base
  DISCIPLINE_TYPES = [].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true
end
