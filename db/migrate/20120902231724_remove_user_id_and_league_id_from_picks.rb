class RemoveUserIdAndLeagueIdFromPicks < ActiveRecord::Migration
  def up
    remove_column :picks, :user_id
    remove_column :picks, :league_id
  end

  def down
    add_column :picks, :user_id, :integer
    add_column :picks, :league_id, :integer
  end
end
