class ScoresController < ApplicationController

  def show
    @schedule = Schedule.all.group_by(&:week_id).sort
  end

  def create
    Score.create(params[:score])
    redirect_to request.referrer, notice: "changes saved"
  end

  def update
    Score.update(params[:id], params[:score])
    redirect_to request.referrer, notice: "changes saved"
  end
end
