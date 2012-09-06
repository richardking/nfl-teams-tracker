class AddProcessedToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :processed, :boolean, :default => false

  end
end
