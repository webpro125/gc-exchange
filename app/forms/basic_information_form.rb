require 'reform/form/coercion'

class BasicInformationForm < Reform::Form
  include ProfileImage, Resume

  model :consultant

  property :abstract

  validates :abstract, presence: true, length: { in: 2..1500 }
end
