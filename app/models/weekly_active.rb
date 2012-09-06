class WeeklyActive < ActiveRecord::Base
  belongs_to :pick
  belongs_to :users_league

  def self.league_week(league_id, week_id)
    find_all_by_league_id_and_week_id(league_id, week_id)
  end

  def team
    Pick.find(pick_id).team
  end
end
