FactoryGirl.define do
  factory :contact_request do
    consultant
    user
    approved true
    project_start
    project_end
    message { Faker::Lorem.characters(256) }

  end
end
