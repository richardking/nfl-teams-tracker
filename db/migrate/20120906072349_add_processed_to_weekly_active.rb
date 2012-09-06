class AddProcessedToWeeklyActive < ActiveRecord::Migration
  def change
    add_column :weekly_actives, :processed, :boolean, :default => false

  end
end
