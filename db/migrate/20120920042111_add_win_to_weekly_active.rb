class AddWinToWeeklyActive < ActiveRecord::Migration
  def change
    add_column :weekly_actives, :win, :boolean

  end
end
