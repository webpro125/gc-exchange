require 'factory_girl_rails'
require 'faker'

namespace :db do
  desc 'Seed database with fake data'
  task fake_data: :environment do
    100.times do
      consultant = FactoryGirl.create(:confirmed_consultant)

      consultant.project_histories << FactoryGirl.create_list(:project_history, 5)
      consultant.consultant_skills << FactoryGirl.create_list(:consultant_skill, 8)
      consultant.military = FactoryGirl.create(:military)
      consultant.address = FactoryGirl.create(:address)
    end
  end
end
