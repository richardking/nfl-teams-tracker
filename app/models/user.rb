class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :leagues_attributes

  validates_presence_of :first_name, :last_name

  validates :email, :uniqueness => true

  has_many :picks, :dependent => :destroy
  has_many :teams, :through => :picks
  has_many :users_leagues, :dependent => :destroy
  has_many :leagues, :through => :users_leagues

  accepts_nested_attributes_for :leagues

  def find_teams(league_id)
    picks.select{|p| p.league_id == league_id.to_i}.map{|p| Team.find(p.team_id)}
  end

end
