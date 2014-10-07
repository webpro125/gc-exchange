# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address1 '1619 3rd Ave'
    city 'New York'
    state 'NY'
    zipcode '10128'

    trait :as_consultant do
      association :addressable,  factory: :consultant
    end

    trait :as_company do
      association :addressable,  factory: :company
    end
  end
end
