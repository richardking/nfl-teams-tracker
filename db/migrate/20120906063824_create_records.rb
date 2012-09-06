class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :team_id
      t.integer :season
      t.integer :wins, :default => 0
      t.integer :losses, :default => 0

      t.timestamps
    end
  end
end
