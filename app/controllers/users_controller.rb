class UsersController < ApplicationController

  def show
    @all_leagues = League.all
    @current_user_leagues = current_user.leagues
    @current_user_teams = current_user.teams
    @all_teams_names = Team.all.each.map{|t| "#{t.city} #{t.name}"}
  end
end
