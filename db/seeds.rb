# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new(
:email => 'byron.weiss@gmail.com',
:name => 'Byron Weiss',
:password => 'helloworld',
:password_confirmation => 'helloworld'
)
# user.skip_confirmation!
user.save!

puts 'seeds planted'
