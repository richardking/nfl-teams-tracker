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
    current_user.users_leagues.create(league_id:params[:id])
    redirect_to request.referrer
  end

end
