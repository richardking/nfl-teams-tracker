class AddUsersLeagueIdToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :users_league_id, :integer

    if Pick.count > 0
      Pick.all.each do |p|
        p.update_attribute(:users_league_id, UsersLeague.find_by_user_id_and_league_id(p.user_id, p.league_id).id)
      end
    end
  end
end
