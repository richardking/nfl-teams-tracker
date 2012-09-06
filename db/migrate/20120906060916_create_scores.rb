class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :schedule_id
      t.integer :home_team_score
      t.integer :away_team_score

      t.timestamps
    end
  end
end
