FactoryGirl.define do
  factory :contact_request do
    consultant
    company
    approved true
    project_start
    project_end

  end
end
