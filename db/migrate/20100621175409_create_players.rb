class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :name
      t.string :team
      t.string :AVG
      t.integer :HR
      t.integer :RBI
      t.integer :RUNS
      t.integer :SB
      t.string :OPS
      t.integer :GAMES
      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
