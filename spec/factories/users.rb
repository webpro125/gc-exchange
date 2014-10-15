# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { "#{first_name}.#{last_name}@fakeemail.com" }
    password              { 'password' }
    password_confirmation { 'password' }

    trait :as_owner do


    end

    trait :as_part_of_company do
      company
    end
  end

  factory :confirmed_user, parent: :user do
    before(:create) { |user| user.skip_confirmation! }
  end
end
