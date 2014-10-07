# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sales_lead do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    company_name          { Faker::Name.name }
    message               { Faker::Lorem.paragraph(5) }
    email                 { "#{first_name}.#{last_name}@fakeemail.com" }
    phone_number          { Faker::PhoneNumber.phone_number }
  end
end
