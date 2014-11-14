FactoryGirl.define do
  factory :education do
    consultant
    degree
    school { Faker::Company.name }
    field_of_study { Faker::Company.bs }
  end
end
