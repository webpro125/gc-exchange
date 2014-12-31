namespace :db do
  desc 'Seed database with fake data'
  task fake_data: :environment do
    begin
      require 'factory_girl_rails'
      require 'faker'

      positions = Position.all
      project_types = ProjectType.all
      skills = Skill.all
      certifications = Certification.all
      clearance_levels = ClearanceLevel.all

      100.times do
        consultant = FactoryGirl.create(:confirmed_consultant, :approved)

        consultant.skills << skills.sample(5)
        consultant.certifications << certifications.sample(3)
        FactoryGirl.create(:military,
                           consultant: consultant,
                           clearance_level: clearance_levels.sample)
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
    rescue
      puts 'factory_girl_rails not found'
    end
  end
end
