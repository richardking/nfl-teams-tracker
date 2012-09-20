class Score < ActiveRecord::Base
  belongs_to :schedule

  validates_uniqueness_of :schedule_id

  after_save :update_records

  protected

  def update_records
    if home_team_score > away_team_score
      home_team_id = self.schedule.home_team_id
      away_team_id = self.schedule.away_team_id
      unless Schedule.find(self.schedule_id).processed
        record = Record.find_or_initialize_by_team_id_and_season(home_team_id, 2012)
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
        record = Record.find_or_initialize_by_team_id_and_season(away_team_id, 2012)
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
        record = Record.find_or_initialize_by_team_id_and_season(home_team_id, 2012)
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
        record = Record.find_or_initialize_by_team_id_and_season(away_team_id, 2012)
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
