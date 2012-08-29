class AddByeWeekToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :bye_week, :integer

  end
end
