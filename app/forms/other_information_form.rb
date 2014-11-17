class OtherInformationForm < Reform::Form
  include Reform::Form::ModelReflections, OtherInformation

  model :consultant
end
