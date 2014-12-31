# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { "#{first_name}.#{last_name}@fakeemail.com" }
    password              { 'password' }
    password_confirmation { 'password' }

    trait :with_company do
      after(:build) do |user|
        user.company = create(:company, :with_owner)
      end
    end

    trait :as_owner do
      after(:build) do |user|
        user.owned_company = create(:company, owner: user)
      end
    end

    after(:build) { |user| user.skip_confirmation! }
  end

  factory :gces_user, parent: :user do
    after(:build) do |user|
      user.build_owned_company(company_name: Company::GLOBAL_CONSULTANT_EXCHANGE)
    end
  end
end
