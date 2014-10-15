# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    consultant
    address1 '1619 3rd Ave'
    city 'New York'
    state 'NY'
    zipcode '10128'
  end
end
