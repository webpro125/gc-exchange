class BackgroundInformationForm < Reform::Form
  model :consultant

  property :background, populate_if_empty: Background do
    property :citizen
    property :convicted
    property :parole
    property :illegal_drug_use
    property :illegal_purchase
    property :illegal_prescription
    property :information_is_correct

    validates :information_is_correct, acceptance: true
  end
end
