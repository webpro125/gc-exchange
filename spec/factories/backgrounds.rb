FactoryGirl.define do
  factory :background do
    consultant
    citizen false
    convicted false
    parole false
    illegal_drug_use false
    illegal_purchase false
    illegal_prescription false
  end

end