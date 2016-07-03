require 'reform/form/coercion'

class BurAcceptForm < Reform::Form

  model :business_unit_role

  properties :cell_area_code, :cell_prefix, :cell_line
  properties :aa_accept, :sa_accept, :ra_accept

  validates :cell_area_code, :cell_prefix,
            length: { is: 3 }, presence: true,  :numericality => true
  validates :cell_line, length: { is: 4 }, presence: true,  :numericality => true

end
