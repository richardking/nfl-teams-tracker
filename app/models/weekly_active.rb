class WeeklyActive < ActiveRecord::Base
  belongs_to :pick
  belongs_to :users_league

  attr_accessible :processed, :user_id, :league_id, :pick_id, :week_id, :users_league_id

  def self.league_week(league_id, week_id)
    find_all_by_league_id_and_week_id(league_id, week_id)
  end

  def team
    Pick.find(pick_id).team
  end
end
