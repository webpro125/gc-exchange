# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_history do
    consultant
    client_company 'MyString'
    client_poc_name 'MyString'
    client_poc_email 'MyString@email.com'
    start_date { 3.years.ago }
    end_date { 6.months.ago }
    description 'MyText'
    position
  end
end
