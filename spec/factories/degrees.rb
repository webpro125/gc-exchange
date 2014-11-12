FactoryGirl.define do
  factory :degree do
    code { Faker::Code.isbn[0..20] }
    label { Faker::Lorem.sentence(3) }
  end
end
