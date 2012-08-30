class Schedule < ActiveRecord::Base
  attr_accessible :week_id, :gametime, :home_team_id, :away_team_id

  validates_presence_of :week_id, :gametime, :home_team_id, :away_team_id

  belongs_to :home_team, :class_name => "Team"
  belongs_to :away_team, :class_name => "Team"
end
