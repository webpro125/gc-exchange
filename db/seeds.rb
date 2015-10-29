# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Company.find_by_company_name(Company::GLOBAL_CONSULTANT_EXCHANGE)
  user = User.create(first_name: 'James',
                     last_name: 'Stoup',
                     email: 'jstoup@thoriumllc.com')

  user.skip_confirmation!
  Company.create(company_name: Company::GLOBAL_CONSULTANT_EXCHANGE, owner: user)
end

# Skills are set up differently
Skill::SKILL_TYPES.each do |type|
  Skill.find_or_create_by(code: type)
end

# All of the lookups
PhoneType::PHONE_TYPES.each do |type|
  PhoneType.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
  end
end

ClearanceLevel::CLEARANCE_LEVEL_TYPES.each do |type|
  ClearanceLevel.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
  end
end

Rank::RANK_TYPES.each do |type|
  Rank.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
  end
end

CustomerName::CUSTOMER_NAME_TYPES.each do |type|
  CustomerName.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
  end
end

Position::POSITION_TYPES.each do |type|
  Position.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
    t.market_id = type[:market_id]
  end
end

Markets::MARKETS.each do |type|
  Markets.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
    t.market_id = type[:market_id]
  end
end

Branch::BRANCH_TYPES.each do |type|
  Branch.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
  end
end

ProjectType::PROJECT_TYPE_TYPES.each do |type|
  ProjectType.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
  end
end

ApprovedStatus::APPROVED_STATUS_TYPES.each do |type|
  ApprovedStatus.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
  end
end

Certification::CERTIFICATION_TYPES.each do |type|
  Certification.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
  end
end

Degree::DEGREE_TYPES.each do |type|
  Degree.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
  end
end

TravelAuthorization::TRAVEL_AUTHORIZATION_TYPES.each do |type|
  TravelAuthorization.find_or_create_by(code: type[:code]) do |t|
    t.label = type[:label]
  end
end

if CustomerName.find_by_label('Marine Corpse Intelligence Activity')
  marine =  CustomerName.find_by_label('Marine Corpse Intelligence Activity')
  marine.label = 'Marine Corps Intelligence Activity'
  marine.save!
end
