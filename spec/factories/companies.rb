# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    company_name { Faker::Name.name }
    association :company_owner,  factory: :user

    after(:create)        { |company| company.users << build_list(:user, 3, company: @company) }
  end
end
