# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :consultant do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { "#{first_name}.#{last_name}@fakeemail.com" }
    password              { 'password' }
    password_confirmation { 'password' }

    trait :approved do
      after(:create) do |c|
        c.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::APPROVED)
      end
    end
  end

  factory :confirmed_consultant, parent: :consultant do
    before(:create) { |consultant| consultant.skip_confirmation! }
  end
end
