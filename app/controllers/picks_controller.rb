class PicksController < ApplicationController

  def edit
    @all_available_teams = Team.all - Team.picked(params[:id])
    @joined_leagues = current_user.leagues
    @current_user_teams = current_user.find_teams(params[:id])
  end

  def create
    Pick.create(params[:pick])
    redirect_to action: 'edit'
  end

  def destroy
    @pick = Pick.find_by_user_id_and_team_id(params[:id], params[:team_id])
    Rails.logger.debug @pick
    if @pick.destroy
      redirect_to request.referrer, notice: "success!"
    else
      redirect_to request.referrer, notice: "failed"
    end
  end
end
