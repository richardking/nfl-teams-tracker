class AddNumToWeek < ActiveRecord::Migration
  def change
    add_column :weeks, :num, :integer

  end
end
