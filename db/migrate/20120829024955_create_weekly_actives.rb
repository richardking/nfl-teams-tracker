class CreateWeeklyActives < ActiveRecord::Migration
  def change
    create_table :weekly_actives do |t|
      t.integer :user_id
      t.integer :league_id
      t.integer :pick_id
      t.integer :week_id

      t.timestamps
    end
  end
end
