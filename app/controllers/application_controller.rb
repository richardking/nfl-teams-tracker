class ApplicationController < ActionController::Base
  layout 'application'

  helper_method :current_league
  helper_method :current_starters

  def current_league
    @current_league ||= League.find_by_id(session[:current_league_id])
  end

  def current_starters
    @current_starters ||= current_user.starters(session[:current_league_id], League.find_active_week_id)
  end

  protect_from_forgery
end
