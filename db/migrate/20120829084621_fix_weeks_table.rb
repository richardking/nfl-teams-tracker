class FixWeeksTable < ActiveRecord::Migration
  def up
    rename_column :weeks, :deadline, :early_deadline
    add_column :weeks, :weekend_deadline, :datetime
  end

  def down
    rename_column :weeks, :early_deadline, :deadline
    remove_column :weeks, :weekend_deadline
  end
end
