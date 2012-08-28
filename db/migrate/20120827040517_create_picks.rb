class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :team_id

      t.timestamps
    end
  end
end
