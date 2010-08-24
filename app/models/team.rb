class Team < ActiveRecord::Base
  belongs_to :division
  has_many :players
end
