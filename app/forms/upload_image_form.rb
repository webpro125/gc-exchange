require 'reform/form/coercion'

class UploadImageForm < Reform::Form
  include Reform::Form::ModelReflections, ProfileImage

  model :consultant

  def self.reflect_on_association(association)
    Consultant.reflect_on_association(association)
  end

  def new_record?
    @model.new_record?
  end
end
