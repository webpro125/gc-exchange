# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_type do
    code { Faker::Code.isbn[0..12] }
  end
end
