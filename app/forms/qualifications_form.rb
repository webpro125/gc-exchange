require 'reform/form/coercion'

class QualificationsForm < Reform::Form
  include Qualifications, ModelReflections

  model :consultant

  def self.reflect_on_association(association)
    Consultant.reflect_on_association(association)
  end
end
