class Degree < ActiveRecord::Base
  include Lookup

  BACHELOR = { code: 'BACHELOR', label: "Bachelor's Degree" }
  MASTER = { code: 'MASTER', label: "'Master's Degree'" }
  JURIS = { code: 'JURIS', label: 'Juris Doctor (J.D)' }
  MEDICAL = { code: 'MEDICAL', label: 'Doctor of Medicine (M.D)' }
  PHILOSOPHY = { code: 'PHILOSOPHY', label: 'Doctor of Philosophy (Ph.D)' }

  DEGREE_TYPES = [BACHELOR, MASTER, JURIS, MEDICAL, PHILOSOPHY]
end
