class UsersController < ApplicationController

  def show
    session[:current_league_id] = nil
    @all_leagues = League.all
    @current_user_leagues = current_user.leagues
    @all_teams_names = Team.all.each.map{|t| "#{t.city} #{t.name}"}
  end
end
