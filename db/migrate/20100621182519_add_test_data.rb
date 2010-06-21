class AddTestData < ActiveRecord::Migration
  def self.up
	Player.delete_all
	25.times {
		Player.create(:name => 'Joe Smith', :team => 'Boston Red Sox', :AVG => 0.300, :HR => 22, :RBI => 44, :RUNS 					=> 33, :SB => 2, :OPS => 0.900)
	}
  end

  def self.down
	Player.delete_all
  end
end
