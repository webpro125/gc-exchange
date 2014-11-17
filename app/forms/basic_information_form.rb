class BasicInformationForm < Reform::Form
  model :consultant

  property :abstract

  validates :abstract, presence: true, length: { in: 2..1500 }
end
