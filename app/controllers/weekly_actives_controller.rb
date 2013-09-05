class WeeklyActivesController < ApplicationController

  def new
    if Pick.find(params[:pick_id]).team.this_week_locked?(League.find_active_week_id)
      redirect_to request.referrer, alert: "Team is locked, game has already started"
      return false
    end
    if WeeklyActive.find_all_by_user_id_and_league_id_and_week_id(params[:user_id], params[:league_id], League.find_active_week_id).count < 6
      users_league_id = UsersLeague.find_by_user_id_and_league_id(params[:user_id], params[:league_id])
      WeeklyActive.create(league_id: params[:league_id], user_id: params[:user_id], week_id: League.find_active_week_id, pick_id: params[:pick_id], users_league_id: users_league_id.id)
      redirect_to request.referrer, flash: { success: "Success!"}
    else
      redirect_to request.referrer, alert: "You already have 6 teams starting"
    end
  end

  def destroy
    team = WeeklyActive.find(params[:weekly_active])
    if Pick.find(team.pick_id).team.this_week_locked?(team.week_id)
      redirect_to request.referrer, alert: "Team is locked, game has already started"
      return false
    end
    WeeklyActive.find(params[:weekly_active]).destroy
    redirect_to request.referrer, flash: { success: "Success!"}
  end
end
