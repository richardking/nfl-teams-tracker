class WeeklyActivesController < ApplicationController

  before_filter :check_deadline

  def new
    if WeeklyActive.find_all_by_user_id_and_league_id_and_week_id(params[:user_id], params[:league_id], params[:id]).count < 6
      WeeklyActive.create(league_id: params[:league_id], user_id: params[:user_id], week_id: params[:id], pick_id: params[:pick_id])
      redirect_to request.referrer, flash: { success: "Success!"}
    else
      redirect_to request.referrer, alert: "You already have 6 teams starting"
    end
  end

  def destroy
    WeeklyActive.find(params[:weekly_active]).destroy
    redirect_to request.referrer, flash: { success: "Success!"}
  end

  def check_deadline
    redirect_to request.referrer, alert: "It's past this week's deadline to make roster updates" if (Week.find_by_num(params[:id]).early_deadline - Time.now < 0)
  end

end
