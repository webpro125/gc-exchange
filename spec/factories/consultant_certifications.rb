# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :consultant_certification do
    consultant
    certification
  end
end
