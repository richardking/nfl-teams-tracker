class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :leagues_attributes

  validates_presence_of :first_name, :last_name

  has_many :teams, :through => :picks
  has_many :users_leagues, :dependent => :destroy
  has_many :leagues, :through => :users_leagues

  accepts_nested_attributes_for :leagues

  def find_teams(league_id)
    ul = UsersLeague.find_by_user_id_and_league_id(self.id, league_id)
    ul.picks.map{|p| Team.find(p.team_id)} if ul.picks
  end

  def find_picks(league_id)
    UsersLeague.find_by_user_id_and_league_id(self.id, league_id).picks
  end

  def starters(league_id, week_id)
    WeeklyActive.find_all_by_user_id_and_league_id_and_week_id(self.id, league_id, week_id).map{|w| w.pick}
  end

  def bench(league_id, week_id)
    bench = find_picks(league_id).map{|p| p.id} - starters(league_id, week_id).map{|s| s.id}
    Pick.find(bench)
  end

end
