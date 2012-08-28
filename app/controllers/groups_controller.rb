class GroupsController < ApplicationController

  def show
    @current_user_teams = current_user.find_teams(params[:id])
    @all_teams_names = Team.all.each.map{|t| "#{t.city} #{t.name}"}
  end
end
