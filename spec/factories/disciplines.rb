# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discipline do
    code          { Faker::Code.isbn }
  end
end
