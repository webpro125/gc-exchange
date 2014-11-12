# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone_type do
    code      { Faker::Code.isbn[0..5] }
    label { Faker::Lorem.characters(256) }
  end
end
