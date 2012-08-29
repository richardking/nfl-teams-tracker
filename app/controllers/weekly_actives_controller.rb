class WeeklyActivesController < ApplicationController

  def new
    Rails.logger.debug params
    WeeklyActive.create(league_id: params[:league_id], user_id: params[:user_id], week_id: params[:id], pick_id: params[:pick_id])
    redirect_to request.referrer
  end

  def destroy
    Rails.logger.debug params
    WeeklyActive.find(params[:weekly_active]).destroy
    redirect_to request.referrer
  end

end
