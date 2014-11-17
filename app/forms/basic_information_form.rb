class BasicInformationForm < Reform::Form
  include Reform::Form::ModelReflections, ProfileImage, Resume

  model :consultant

  property :abstract

  # validates :abstract, presence: true, length: { in: 2..1500 }

  def self.reflect_on_association(association)
    Consultant.reflect_on_association(association)
  end

  def new_record?
    @model.new_record?
  end
end
