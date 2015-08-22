class AddVictimIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :victim_id, :integer
  end
end
