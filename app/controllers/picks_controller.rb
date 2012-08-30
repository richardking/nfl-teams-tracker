class PicksController < ApplicationController

  def edit
    @all_available_teams = Team.order(:city).all - Team.picked(params[:id])
    @joined_leagues = current_user.leagues
    @user_teams = current_user.find_teams(params[:id])
  end

  def create
    Pick.create(params[:pick])
    redirect_to action: 'edit'
  end

  def destroy
    @pick = Pick.find_by_user_id_and_team_id(params[:id], params[:team_id])
    if @pick.destroy
      redirect_to request.referrer, flash: {success: "success!"}
    else
      redirect_to request.referrer, alert: "failed"
    end
  end
end
