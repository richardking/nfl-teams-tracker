class Score < ActiveRecord::Base
  belongs_to :schedule

  validates_uniqueness_of :schedule_id

  after_save :update_records

  class << self
    def parse
      @scores_entered = []
      json = HTTParty.get("http://data.t.bleacherreport.com/NFL_Reg/Football/2013/schedule.json")
      json['games'].each do |game|
        next unless game['state']['gameStatus'] == 'closed'

        game['teams'].each do |t|
          if t['home'].to_s == "true"
            @home_team = [Team.find_by_abbr(t['teamId']).id, t['score']]
          else
            @away_team = [Team.find_by_abbr(t['teamId']).id, t['score']]
          end
        end
        puts game.inspect

        @schedule = Schedule.find_by_home_team_id_and_away_team_id_and_processed(@home_team[0], @away_team[0], false)
        if @schedule.nil?
          @schedule_errors << [@home_team[0], @away_team[0]]
          next
        end

        if score = Score.create(schedule_id: @schedule.id, away_team_score: @home_team[1], home_team_score: @away_team[1])
          @scores_entered << score.id
          Schedule.find(@schedule.id).update_attribute(:processed, true)
        else
          @schedule_errors << @schedule.id
        end

      end

      puts "ERRORS: #{@schedule_errors.inspect}"
    end
  end

  protected

  def update_records
    if home_team_score > away_team_score
      home_team_id = self.schedule.home_team_id
      away_team_id = self.schedule.away_team_id
      unless Schedule.find(self.schedule_id).processed
        record = Record.find_or_initialize_by_team_id_and_season(home_team_id, 2013)
        record.update_attribute(:wins, (record.wins + 1))
        record.save
      end
      WeeklyActive.find_all_by_week_id(self.schedule.week_id).each do |wa|
        if wa.pick.team.id == home_team_id && !wa.processed
          wa.update_attribute(:processed, true)
          wa.update_attribute(:win, true)
          wa.users_league.update_attribute(:wins, (wa.users_league.wins + 1))
        end
      end
      unless Schedule.find(self.schedule_id).processed
        Schedule.find(self.schedule_id).update_attribute(:processed, true)
        record = Record.find_or_initialize_by_team_id_and_season(away_team_id, 2013)
        record.update_attribute(:losses, (record.losses + 1))
        record.save
      end
      WeeklyActive.find_all_by_week_id(self.schedule.week_id).each do |wa|
        if wa.pick.team.id == away_team_id && !wa.processed
          wa.update_attribute(:processed, true)
          wa.update_attribute(:win, false)
          wa.users_league.update_attribute(:losses, (wa.users_league.losses + 1))
        end
      end
    else
      home_team_id = self.schedule.home_team_id
      away_team_id = self.schedule.away_team_id
      unless Schedule.find(self.schedule_id).processed
        record = Record.find_or_initialize_by_team_id_and_season(home_team_id, 2013)
        record.update_attribute(:losses, (record.losses + 1))
        record.save
      end
      WeeklyActive.find_all_by_week_id(self.schedule.week_id).each do |wa|
        if wa.pick.team.id == home_team_id && !wa.processed
          wa.update_attribute(:processed, true)
          wa.update_attribute(:win, false)
          wa.users_league.update_attribute(:losses, (wa.users_league.losses + 1))
        end
      end
      unless Schedule.find(self.schedule_id).processed
        Schedule.find(self.schedule_id).update_attribute(:processed, true)
        record = Record.find_or_initialize_by_team_id_and_season(away_team_id, 2013)
        record.update_attribute(:wins, (record.wins + 1))
        record.save
      end
      WeeklyActive.find_all_by_week_id(self.schedule.week_id).each do |wa|
        if wa.pick.team.id == away_team_id && !wa.processed
          wa.update_attribute(:processed, true)
          wa.update_attribute(:win, true)
          wa.users_league.update_attribute(:wins, (wa.users_league.wins + 1))
        end
      end
    end
  end

end
