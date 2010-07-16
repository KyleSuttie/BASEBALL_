class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :team_id
      t.string :name
      t.string :team
      t.string :avg
      t.integer :hr
      t.integer :rbi
      t.integer :runs
      t.integer :sb
      t.string :ops
      t.integer :games
      t.timestamps
    end
    create_table :teams do |t|
      t.string :city
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :players
    drop_table :teams
  end
end
