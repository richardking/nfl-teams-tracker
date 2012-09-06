class FixColumnNameForWeek < ActiveRecord::Migration
  def up
    rename_column :weeks, :year, :season
  end

  def down
    rename_column :weeks, :season, :year
  end
end
