# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    number            { Faker::PhoneNumber.cell_phone }
    phone_type
    association       :phoneable, factory: :consultant
  end
end
