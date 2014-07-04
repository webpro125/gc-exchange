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
