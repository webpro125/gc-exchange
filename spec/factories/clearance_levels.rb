# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :clearance_level do
    code { Faker::Code.isbn[0..5] }
  end
end
