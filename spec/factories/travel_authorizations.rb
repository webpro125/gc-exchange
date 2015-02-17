FactoryGirl.define do
  factory :travel_authorization do
    code      { Faker::Code.isbn[0..5] }
    label { Faker::Lorem.characters(256) }
  end
end
