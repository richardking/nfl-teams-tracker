class LeaguesController < ApplicationController

  def league_controller?
    true
  end

  def show
    session[:current_league_id] = params[:id]
    @active_week = League.find_active_week
    @this_weeks_games = Schedule.find_all_by_week_id(Week.find_by_num(@active_week))
    if params[:user_id]
      @user = User.find(params[:user_id])
      @users_league = UsersLeague.find_by_user_id_and_league_id(params[:user_id], params[:id])
    else
      @user = current_user
      @users_league = UsersLeague.find_by_user_id_and_league_id(current_user.id, params[:id])
    end
    @user_teams = @user.find_teams(params[:id])
    @current_users_leagues = League.find(params[:id]).users_leagues
  end

  def join
    if League.find(params[:id]).users.count <= 6
      current_user.users_leagues.create(league_id:params[:id])
      league = League.find(params[:id])
      redirect_to league_path(league), notice: "Joined #{league.name}"
    else
      redirect_to request.referrer, alert: "Max players reached for that league"
    end
  end

  def parse
    @scores = Array.new
    @schedule_errors = Array.new
    @scores_entered = Array.new
    Rails.logger.debug "Parse"
    feed = Feedzirra::Feed.fetch_and_parse("http://feeds.feedburner.com/mpiii/nfl")
    feed.entries.each do |entry|
      entry.title = entry.title.gsub("NY Giants", "NYG").gsub("NY Jets", "NYJ")
      Rails.logger.debug entry.title
      if /(FINAL)/.match(entry.title)
        Rails.logger.debug entry.title
        @scores << entry.title.gsub(" (FINAL)", "")
      end
    end
    Rails.logger.debug @scores
    @scores.each do |score|
      teams = score.split("   ")
      Rails.logger.debug teams
      teams.map! do |team|
        t = team.match(/(\D+) (\d+)/)
        [t[1], t[2]]
      end
      teams.flatten!
      Rails.logger.debug teams
      away_team_id = Team.find_by_city(teams[0]).try(:id) || Team.find_by_abbr(teams[0]).id
      home_team_id = Team.find_by_city(teams[2]).try(:id) || Team.find_by_abbr(teams[2]).id
      Rails.logger.debug away_team_id
      Rails.logger.debug home_team_id
      schedule_id = Schedule.find_by_away_team_id_and_home_team_id(away_team_id, home_team_id).id
      if score = Score.create(schedule_id: schedule_id, away_team_score: teams[1], home_team_score: teams[3])
        Rails.logger.debug score
        @scores_entered << score.id
        Schedule.find(schedule_id).update_attribute(:processed, true)
      else
        @schedule_errors << schedule_id
      end
    end
  end

end
