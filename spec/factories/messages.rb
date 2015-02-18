FactoryGirl.define do
  factory :message do
    subject { Faker::Lorem.characters(24) }
    message { Faker::Lorem.characters(256) }
  end
end
