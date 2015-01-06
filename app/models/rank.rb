class Rank < ActiveRecord::Base
  include Lookup

  O1 = { code: 'O1', label: 'O1' }
  O2 = { code: 'O2', label: 'O2' }
  O3 = { code: 'O3', label: 'O3' }
  O4 = { code: 'O4', label: 'O4' }
  O5 = { code: 'O5', label: 'O5' }
  O6 = { code: 'O6', label: 'O6' }
  O7 = { code: 'O7', label: 'O7' }
  O8 = { code: 'O8', label: 'O8' }
  O9 = { code: 'O9', label: 'O9' }
  O10 = { code: 'O10', label: 'O10' }
  W1 = { code: 'W1', label: 'W1' }
  W2 = { code: 'W2', label: 'W2' }
  W3 = { code: 'W3', label: 'W3' }
  W4 = { code: 'W4', label: 'W4' }
  W5 = { code: 'W5', label: 'W5' }
  E1 = { code: 'E1', label: 'E1' }
  E2 = { code: 'E2', label: 'E2' }
  E3 = { code: 'E3', label: 'E3' }
  E4 = { code: 'E4', label: 'E4' }
  E5 = { code: 'E5', label: 'E5' }
  E6 = { code: 'E6', label: 'E6' }
  E7 = { code: 'E7', label: 'E7' }
  E8 = { code: 'E8', label: 'E8' }
  E9 = { code: 'E9', label: 'E9' }

  RANK_TYPES = [O1, O2, O3, O4, O5, O6, O7, O8, O9, O10, W1, W2, W3, W4, W5, E1, E2, E3, E4, E5, E6,
                E7, E8, E9].freeze
end
