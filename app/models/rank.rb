class Rank < ActiveRecord::Base
  RANK_TYPES = [].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true, presence: true
end
