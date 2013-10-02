# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

coop = User.new(email: ENV['COOP_EMAIL'], password: ENV['COOP_PASSWORD'], password_confirmation: ENV['COOP_PASSWORD'])
coop.skip_confirmation!
coop.save!