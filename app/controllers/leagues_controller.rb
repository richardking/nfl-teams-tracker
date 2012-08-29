class LeaguesController < ApplicationController

  def league_controller?
    true
  end

  def show
    @current_user_teams = current_user.find_teams(params[:id])
    @current_league_users = League.find(params[:id]).users
    @all_teams_names = Team.all.each.map{|t| "#{t.city} #{t.name}"}
  end

  def join
    current_user.users_leagues.create(league_id:params[:id])
    redirect_to request.referrer
  end
end
