class WeeksController < ApplicationController

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end

  def show
    @user = User.find_by_id(params[:user_id]) || current_user
    @starters = @user.starters(params[:league_id], params[:id])
    @bench = @user.bench(params[:league_id], params[:id])
    @user_picks = @user.find_picks(params[:league_id])
  end

  def edit
    @current_user_picks = current_user.find_picks(params[:league_id])
    @home_team_ids = Array.new
    @away_team_ids = Array.new
    Schedule.find_all_by_week_id(Week.find_by_num(params[:id])).each do |s|
      @home_team_ids << s.home_team_id
      @away_team_ids << s.away_team_id
    end
  end
end
