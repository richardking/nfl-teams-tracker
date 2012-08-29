# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Team.delete_all
open("#{Rails.root}/db/seeds/teams.txt") do |teams|
  teams.read.each_line do |team|
    abbr, color, city, name = team.chomp.split(",")
    Team.create!(:abbr => abbr, :color => color, :city => city, :name => name)
  end
end