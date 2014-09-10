# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    number { Faker::PhoneNumber.cell_phone }
    association :phoneable, factory: :consultant
    phone_type
  end
end
