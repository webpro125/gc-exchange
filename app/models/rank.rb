class Rank < ActiveRecord::Base
  RANK_TYPES = [].freeze

  validates :code, length: { maximum: 10 }, uniqueness: true
end
