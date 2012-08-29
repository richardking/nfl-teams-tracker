class Pick < ActiveRecord::Base
  attr_accessible :user_id, :league_id, :team_id

  belongs_to :team
  belongs_to :user

  has_many :weekly_actives, :dependent => :destroy

  def started?(week_id)
    WeeklyActive.find_by_pick_id_and_week_id(self.id, week_id) ? true : false
  end

  def weekly_active(week_id)
    WeeklyActive.find_by_pick_id_and_week_id(self.id, week_id)
  end
end
