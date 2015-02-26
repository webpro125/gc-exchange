# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shared_contact do
    association :user, :with_company
    association :consultant, :approved
    allowed false
  end
end
