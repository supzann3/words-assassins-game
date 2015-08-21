class SetColumnDefaults < ActiveRecord::Migration
  def change
    change_column :players, :alive?, :boolean, :default => true
    change_column :players, :kills, :integer, :default => 0
  end
end
