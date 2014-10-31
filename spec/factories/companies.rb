# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    company_name { Faker::Name.name }

    trait :with_owner do
      owner  { FactoryGirl.build(:user) }
    end
  end

  factory :gces_company, parent: :company do
    company_name { Company::GLOBAL_CONSULTANT_EXCHANGE }
  end
end
