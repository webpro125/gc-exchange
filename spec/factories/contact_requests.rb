FactoryGirl.define do
  factory :contact_request do
    consultant
    association :user, :with_company
    project_start { 3.months.from_now }
    project_end { 7.months.from_now }
    project_name { Faker::Lorem.characters(24) }
    project_location '1619 3rd Ave New York, NY 10128'
    message { Faker::Lorem.characters(256) }
    subject { Faker::Lorem.characters(24) }
    contact_status :pending

  end
end
