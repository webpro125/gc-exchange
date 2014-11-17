require 'reform/form/coercion'

class QualificationsForm < Reform::Form
  include Qualifications

  model :consultant
end
