class PicksController < ApplicationController

  def edit
    @all_available_teams = Team.order(:city).all - Team.picked(params[:id])
    @joined_leagues = current_user.leagues
    @user_teams = current_user.find_teams(params[:id])
  end

  def create
    if Pick.find_by_user_id_and_league_id_and_team_id(params[:pick][:user_id], params[:pick][:league_id], params[:pick][:team_id])
      redirect_to request.referrer, alert: "Team has been selected already!"
    else
      Pick.create(params[:pick])
      redirect_to request.referrer, notice: "Added #{Team.find(params[:pick][:team_id]).name}"
    end
  end

  def destroy
    @pick = Pick.find_by_user_id_and_team_id(params[:id], params[:team_id])
    if @pick.destroy
      redirect_to request.referrer, notice: {success: "success!"}
    else
      redirect_to request.referrer, alert: "failed"
    end
  end
end
