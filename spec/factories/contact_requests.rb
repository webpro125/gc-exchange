FactoryGirl.define do
  factory :contact_request do
    consultant
    association :user, :with_company
    project_start { 3.months.from_now }
    project_end { 7.months.from_now }
    message { Faker::Lorem.characters(256) }
    contact_status :pending

  end
end
