class Player < ActiveRecord::Base
  belongs_to :team
  cattr_reader :per_page
  @@per_page = 25


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
end
