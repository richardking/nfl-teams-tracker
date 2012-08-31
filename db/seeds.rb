# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Team.delete_all
# open("#{Rails.root}/db/seeds/teams.txt") do |teams|
#   teams.read.each_line do |team|
#     abbr, color, city, name = team.chomp.split(",")
#     Team.create!(:abbr => abbr, :color => color, :city => city, :name => name)
#   end
# end

# Week.delete_all
# open("#{Rails.root}/db/seeds/weeks.txt") do |week_all|
#   week_all.read.each_line do |week|
#     num, datetime = week.chomp.split("|")
#     deadline = DateTime.instance_eval(datetime)
#     Week.create!(:num => num, :early_deadline => deadline)
#   end
# end

# Schedule.delete_all
# open("#{Rails.root}/db/seeds/schedule.txt") do |schedule_all|
#   schedule_all.read.each_line do |schedule|
#     date, time, week, away, home = schedule.chomp.split(",")
#     gametime = DateTime.parse([date, time].join(' ').sub(%r_\A\s*(\d{1,2})/(\d{1,2})/(\d{4}|\d{2})_.freeze){|m| "#$3-#$1-#$2"}) + 7.hours
#     week = week.first(11).gsub(/\D/,'').to_i
#     week_id = Week.find_by_num(week).id
#     away_team_id = Team.find_by_name(away.strip).id
#     home_team_id = Team.find_by_name(home.strip).id
#     Schedule.create!(gametime: gametime, week_id: week_id, away_team_id: away_team_id, home_team_id: home_team_id)
#   end
# end

Week.all.each do |week|
  time = ("Sept 10, 2012 9:00 PM").to_time + 7.hours + (7*(week.num-1)).days
  week.update_attributes(end_of_week: time, year: 2012)
end