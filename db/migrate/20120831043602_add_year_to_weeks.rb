class AddYearToWeeks < ActiveRecord::Migration
  def change
    add_column :weeks, :year, :integer
    add_column :weeks, :end_of_week, :datetime
    remove_column :weeks, :early_deadline
    remove_column :weeks, :weekend_deadline

  end
end
