# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_history_position do
    project_history
    position
    percentage 100
  end
end
