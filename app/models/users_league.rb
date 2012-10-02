class UsersLeague < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  has_many :weekly_actives, :dependent => :destroy

  has_many :picks, :dependent => :destroy

  attr_accessible :wins, :losses

  def wins_in_week(week_id)
    weekly_actives.where("week_id = #{week_id} AND win = true").count
  end

  def losses_in_week(week_id)
    weekly_actives.where("week_id = #{week_id} AND win = false").count
  end

  def current_rank
    league.users_leagues.sort_by(&:wins).reverse.map(&:id).index(id)
  end
end
