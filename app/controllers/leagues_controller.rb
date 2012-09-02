class LeaguesController < ApplicationController

  def league_controller?
    true
  end

  def show
    @active_week = League.find_active_week
    @this_weeks_games = Schedule.find_all_by_week_id(Week.find_by_num(@active_week))
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
    @user_teams = @user.find_teams(params[:id])
    @current_league_users = League.find(params[:id]).users
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

end
