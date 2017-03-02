class AddFounderToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :founder, :string
  end
end
