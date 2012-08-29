class WeeksController < ApplicationController

  def show
    Rails.logger.debug params
    @starters = current_user.starters(params[:league_id], params[:id])
    @bench = current_user.bench(params[:league_id], params[:id])
    @current_user_picks = current_user.find_picks(params[:league_id])
  end

  def edit
    @current_user_picks = current_user.picks.find_all_by_league_id(params[:league_id])
  end
end
