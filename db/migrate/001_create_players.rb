class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :email
      t.integer :kills
      t.boolean :alive?
      t.string :word
    end
  end
end
