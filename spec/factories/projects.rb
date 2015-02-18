FactoryGirl.define do
  factory :project do
    consultant
    travel_authorization
    association :user, :with_company
    proposed_start { 3.months.from_now }
    proposed_end { 7.months.from_now }
    proposed_rate 100.00
    project_name { Faker::Lorem.characters(24) }
    project_location '1619 3rd Ave New York, NY 10128'
    contact_status :hired
  end
end
