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

end
