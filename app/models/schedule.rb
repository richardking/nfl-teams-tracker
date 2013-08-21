class Schedule < ActiveRecord::Base
  attr_accessible :week_id, :gametime, :home_team_id, :away_team_id, :processed

  validates_presence_of :week_id, :gametime, :home_team_id, :away_team_id

  belongs_to :home_team, :class_name => "Team"
  belongs_to :away_team, :class_name => "Team"
  has_one :score

  default_scope order('gametime ASC')

  class << self
    def import
      start_of_season = DateTime.parse('03/09/2013')
      json = HTTParty.get("http://data.t.bleacherreport.com/NFL_Reg/Football/2013/schedule.json")
      json['games'].each do |game|
        week_num = ((DateTime.parse(game['startTime']).to_i - start_of_season.to_i) / 1.week) + 1
        week_id = Week.find_by_num_and_season(week_num, 2013).id

        game['teams'].each do |t|
          if t['home'].to_s == "true"
            @home_team_id = Team.find_by_abbr(t['teamId']).id
          else
            @away_team_id = Team.find_by_abbr(t['teamId']).id
          end
        end
        Schedule.create(gametime: game['startTime'], week_id: week_id, away_team_id: @away_team_id, home_team_id: @home_team_id)
      end
    end
  end

end

#<Schedule id: 244, gametime: "2012-12-30 20:15:00", week_id: 17, away_team_id: 12, home_team_id: 7, created_at: "2012-08-30 01:44:18", updated_at: "2012-12-31 04:42:45", processed: true>
