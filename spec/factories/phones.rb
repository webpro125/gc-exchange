# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    number { rand(10**9..10**10) }
    association :phoneable, factory: :consultant
    phone_type
    primary false
  end
end
