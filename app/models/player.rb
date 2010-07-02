class Player < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 25
end
