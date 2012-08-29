class AddColorToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :color, :string

    add_column :teams, :abbr, :string

  end
end
