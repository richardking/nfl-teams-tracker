class WeeksController < ApplicationController

  def show
    Rails.logger.debug params
    @current_user_teams = current_user.teams
  end

  def edit

  end
end
