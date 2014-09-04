# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill do
    code { Faker::Code.isbn[0..5] }
  end
end
