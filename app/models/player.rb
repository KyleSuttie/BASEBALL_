class Player < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 25

  def self.save(upload)
    name = upload['datafile'].original_filename
    directory = "public/baseball"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end








  #def file_upload=(field)
  #  self.name = base_part_of(field.original_filename)
  #  self.data = field.read
  #end

end
