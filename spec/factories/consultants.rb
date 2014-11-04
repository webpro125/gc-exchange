# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :consultant do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { "#{first_name}.#{last_name}@fakeemail.com" }
    password              { 'password' }
    password_confirmation { 'password' }
    abstract              { Faker::Lorem.characters(150) }

    trait :approved do
      after(:create) do |c|
        c.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::APPROVED)
        c.save
      end
    end

    trait :in_progress do
      after(:create) do |c|
        c.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::IN_PROGRESS)
        c.save
      end
    end

    trait :rejected do
      after(:create) do |c|
        c.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::REJECTED)
        c.save
      end
    end

    trait :pending_approval do
      after(:create) do |c|
        c.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::PENDING_APPROVAL)
        c.save
      end
    end
  end

  factory :confirmed_consultant, parent: :consultant do
    before(:create) { |consultant| consultant.skip_confirmation! }
  end
end
