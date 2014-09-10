# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[{id: 1, code: PhoneType::WORK},
 {id: 2, code: PhoneType::CELL},
 {id: 3, code: PhoneType::HOME}].each do |type|
  PhoneType.find_or_create_by(type)
end

[{id: 1, code: ClearanceLevel::SECRET},
 {id: 2, code: ClearanceLevel::TS},
 {id: 3, code: ClearanceLevel::TSSCI}].each do |type|
  ClearanceLevel.find_or_create_by(type)
end

# TODO need a list of disciplines that our system allows
