class Rank < ActiveRecord::Base
  O1 = 'O1'
  O2 = 'O2'
  O3 = 'O3'
  O4 = 'O4'
  O5 = 'O5'
  O6 = 'O6'
  O7 = 'O7'
  O8 = 'O8'
  O9 = 'O9'
  O10 = 'O10'
  E1 = 'E1'
  E2 = 'E2'
  E3 = 'E3'
  E4 = 'E4'
  E5 = 'E5'
  E6 = 'E6'
  E7 = 'E7'
  E8 = 'E8'
  E9 = 'E9'

  RANK_TYPES = [O1, O2, O3, O4, O5, O6, O7, O8, O9, O10, E1, E2, E3, E4, E5, E6, E7, E8, E9].freeze

  validates :code, length: { maximum: 32 }, uniqueness: true, presence: true
end
