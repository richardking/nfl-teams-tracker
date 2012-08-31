class Team < ActiveRecord::Base
  has_many :home_games, :foreign_key => :home_team_id, :class_name => "Schedule"
  has_many :away_games, :foreign_key => :away_team_id, :class_name => "Schedule"

  def self.picked(league_id)
    Pick.all.select{|p| p.league_id == league_id.to_i}.map{|p| p.team}
  end

  def full_name
    "#{city} #{name}"
  end

  def bye_week
    a = *(1..17)
    (a - (home_games.map{|g| Week.find(g.week_id).num} + away_games.map{|g| Week.find(g.week_id).num})).first
  end

  def this_weeks_gametime(week_id)
    schedule = Schedule.find_by_week_id_and_home_team_id(week_id, self.id) || Schedule.find_by_week_id_and_away_team_id(week_id, self.id)
    schedule.gametime
  end

  def this_week_locked?(week_id)
    this_weeks_gametime(week_id) - Time.now.utc < 600 ? true : false
  end

  def this_weeks_opponent(week_id)
    schedule = Schedule.find_by_week_id_and_home_team_id(week_id, self.id) || Schedule.find_by_week_id_and_away_team_id(week_id, self.id)
    self == Team.find(schedule.home_team_id) ? Team.find(schedule.away_team_id) : Team.find(schedule.home_team_id)
  end

end
