class Team < ActiveRecord::Base
  belongs_to :division
  has_many :players
  file_column :filename
end
