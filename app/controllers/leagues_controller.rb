class LeaguesController < ApplicationController

  def league_controller?
    true
  end

  def show
    session[:current_league_id] = params[:id]
    @active_week_id = League.find_active_week_id
    @active_week = Week.find(@active_week_id).num
    @previous_week_id = Week.find_by_id_and_season(@active_week_id - 1, 2014).try(:id)
    @this_weeks_games = Schedule.find_all_by_week_id(Week.find(@active_week_id))
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
    @scores_entered, @schedule_errors = Score.parse
  end

end
