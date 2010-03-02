class Track < ActiveRecord::Base
  has_and_belongs_to_many :libraries
  
  def parse(metadata)
    self.persistent_id = metadata[:persistent_id]
    self.name = metadata[:name]
    self.total_time = metadata[:total_time].to_i
    self.artist = metadata[:artist] || ""
    self.album = metadata[:album] || ""
    pc = metadata[:play_count] || "0"
    self.play_count = pc.to_i
  end
end
