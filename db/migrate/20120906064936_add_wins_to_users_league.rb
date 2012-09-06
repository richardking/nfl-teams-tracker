class AddWinsToUsersLeague < ActiveRecord::Migration
  def change
    add_column :users_leagues, :wins, :integer, :default => 0

    add_column :users_leagues, :losses, :integer, :default => 0

  end
end
