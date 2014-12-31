# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer_name do
    code { Faker::Code.isbn[0..8] }
    label { Faker::Lorem.characters(256) }
  end
end
