# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :certification do
    code { Faker::Code.isbn[0..24] }
  end
end
