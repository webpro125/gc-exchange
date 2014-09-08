# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    code          { Faker::Code.isbn }
  end
end
