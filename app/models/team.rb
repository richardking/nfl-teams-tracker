class Team < ActiveRecord::Base
  def self.picked(league_id)
    Pick.all.select{|p| p.league_id == league_id.to_i}.map{|p| p.team}
  end

  def full_name
    "#{city} #{name}"
  end
end
