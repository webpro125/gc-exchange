class OtherInformationForm < Reform::Form
  include Reform::Form::ModelReflections, OtherInformation

  model :consultant

  def self.reflect_on_association(association)
    Consultant.reflect_on_association(association)
  end
end
