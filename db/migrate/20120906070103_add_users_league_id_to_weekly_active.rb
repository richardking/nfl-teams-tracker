class AddUsersLeagueIdToWeeklyActive < ActiveRecord::Migration
  def change
    add_column :weekly_actives, :users_league_id, :integer

    WeeklyActive.all.each do |wa|
      uli = UsersLeague.find_by_user_id_and_league_id(wa.user_id, wa.league_id)
      wa.update_attribute(:users_league_id, uli)
    end
  end
end
