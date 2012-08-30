class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :gametime
      t.integer :week_id
      t.integer :away_team_id
      t.integer :home_team_id

      t.timestamps
    end
  end
end
