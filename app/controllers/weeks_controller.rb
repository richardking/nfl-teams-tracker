class WeeksController < ApplicationController

  def show
    @user = User.find_by_id(params[:user_id]) || current_user
    @starters = @user.starters(params[:league_id], params[:id])
    @bench = @user.bench(params[:league_id], params[:id])
    @user_picks = @user.find_picks(params[:league_id])
  end

  def edit
    @current_user_picks = current_user.picks.find_all_by_league_id(params[:league_id])
  end
end
