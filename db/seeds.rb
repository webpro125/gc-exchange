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

  Company.create(company_name: Company::GLOBAL_CONSULTANT_EXCHANGE, owner: user)
end

PhoneType::PHONE_TYPES.each do |type|
  PhoneType.find_or_create_by(code: type)
end

ClearanceLevel::CLEARANCE_LEVEL_TYPES.each do |type|
  ClearanceLevel.find_or_create_by(code: type)
end

Rank::RANK_TYPES.each do |type|
  Rank.find_or_create_by(code: type)
end

CustomerName::CUSTOMER_NAME_TYPES.each do |type|
  CustomerName.find_or_create_by(code: type)
end

Position::POSITION_TYPES.each do |type|
  Position.find_or_create_by(code: type)
end

Discipline::DISCIPLINE_TYPES.each do |type|
  Discipline.find_or_create_by(code: type)
end

Skill::SKILL_TYPES.each do |type|
  Skill.find_or_create_by(code: type)
end

Branch::BRANCH_TYPES.each do |type|
  Branch.find_or_create_by(code: type)
end

ProjectType::PROJECT_TYPE_TYPES.each do |type|
  ProjectType.find_or_create_by(code: type)
end

ApprovedStatus::APPROVED_STATUS_TYPES.each do |type|
  ApprovedStatus.find_or_create_by(code: type)
end

Certification::CERTIFICATION_TYPES.each do |type|
  Certification.find_or_create_by(code: type)
end
