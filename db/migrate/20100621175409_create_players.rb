class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :team_id
      t.string :name
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
      t.integer :division_id
      t.string :city
      t.string :name
      t.timestamps
    end
    create_table :divisions do |t|
      t.integer :league_id
      t.string :name
      t.timestamps
    end
    create_table :leagues do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :players
    drop_table :teams
    drop_table :divisions
    drop_table :leagues
  end
end
