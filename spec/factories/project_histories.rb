# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_history do
    consultant
    client_company { Faker::Name.name }
    client_poc_name { Faker::Name.first_name }
    client_poc_email { Faker::Internet.email(client_poc_name) }
    start_date { 3.years.ago }
    end_date { 6.months.ago }
    description { Faker::Lorem.paragraph(10) }
    project_type
    position
  end
end
