require "rexml/document"
class PlayerDatabase < ActiveRecord::Migration
include REXML

  def self.is_batter?(player)
    (player.elements[3].text != "Relief Pitcher") and
	(player.elements[3].text != "Starting Pitcher")
  end

  def self.get_at_bats(player)
    Float(player.elements[6].text)
  end

  def self.get_hits(player)
    Float(player.elements[8].text)
  end

  def self.get_hr(player)
    Float(player.elements[11].text)
  end

  def self.get_sacs(player)
    Float(player.elements[16].text)
  end

  def self.get_walks(player)
    Float(player.elements[18].text)
  end

  def self.get_hbp(player)
    Float(player.elements[20].text)
  end

  def self.get_ops(player)
   
    bases = self.get_hits(player) + (Float(player.elements[9].text)*2) + (Float(player.elements[10].text)*3) + (self.get_hr(player)*4)

    obp = ((self.get_hits(player) + self.get_walks(player) + self.get_hbp(player)) / (self.get_at_bats(player) + self.get_walks(player) +
	    self.get_sacs(player)))

    sp = bases / self.get_at_bats(player)
    if (obp + sp).nan?
      "NaN"
    else
      String(obp + sp)
    end
  end

  def self.get_avg(player)
    if (self.get_hits(player)/self.get_at_bats(player)).nan?
      "NaN"
    else
      String(self.get_hits(player)/self.get_at_bats(player))
    end
  end

  def self.up
    file = File.new("baseball_stats.xml")
    doc = REXML::Document.new file
    
    d = 2
    while doc.root.elements[d] != nil
      league = doc.root.elements[d]
      c = 2
      while league.elements[c] != nil
        division = league.elements[c]
        b = 2
        while division.elements[b] != nil
	  team = division.elements[b]
          a = 3
          while team.elements[a] != nil
	    if (self.is_batter?(team.elements[a]))
              player = team.elements[a]  
              Player.create(:name => player.elements[1].text + ' ' + player.elements[2].text,
			    :team => team.elements[1].text + ' ' + team.elements[2].text,
			    :AVG => self.get_avg(player),
			    :HR => self.get_hr(player),
			    :RBI => Float(player.elements[12].text),
			    :RUNS => Integer(player.elements[7].text),
			    :SB => Float(player.elements[13].text),
			    :OPS => self.get_ops(player),
			    :GAMES => Integer(player.elements[4].text))
            end
            a = a + 1
          end
          b = b + 1
        end
        c = c + 1
      end
      d = d + 1
    end
  end
 
  def self.down
    Player.delete_all
  end
end
