require 'factory_girl_rails'
require 'faker'

namespace :db do
  desc 'Seed database with fake data'
  task fake_data: :environment do
    positions = Position.all
    project_types = ProjectType.all
    skills = FactoryGirl.create_list(:skill, 100)

    100.times do
      consultant = FactoryGirl.create(:confirmed_consultant)

      consultant.skills << skills.sample(5)
      FactoryGirl.create(:military, consultant: consultant)
      FactoryGirl.create(:address, consultant: consultant)

      (1..20).to_a.sample.times do
        position = positions.sample
        project_type = project_types.sample
        history = FactoryGirl.build(:project_history,
                                    consultant: consultant,
                                    project_type: project_type)
        history.project_history_positions << FactoryGirl.build(:project_history_position,
                                                               position: position,
                                                               project_history: history)
        history.save
      end
    end
  end
end
