class UsersController < ApplicationController

  def show
    @current_user_teams = current_user.teams
    @all_teams_names = Team.all.each.map{|t| "#{t.city} #{t.name}"}
  end
end
