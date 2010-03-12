require 'nokogiri'

class Library < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tracks
  
  def number_of_tracks
    tracks.count
  end

  def number_of_artists
    tracks.count(:artist, :conditions => "artist <> ''", :distinct => true) 
  end

  def number_of_albums
    tracks.count(:album, :conditions => "album <> ''", :distinct => true)    
  end

  def total_playtime
    tracks.sum(:total_time)
  end

  def total_playtime_formatted
    totalSeconds = total_playtime / 1000
    seconds = totalSeconds % 60; 
    minutes = (totalSeconds / 60) % 60; 
    hours = totalSeconds / 3600;
    duration = sprintf("%d:%02d",hours, minutes)
  end
  
  def top_tracks_by_play_count(n)
    tracks.find :all, :limit => n, :order => "play_count desc" 
  end
  

  # Parses the iTunes Music Library XML to an array of Track and Playlist objects
  def parse(file_path)        
    doc = Nokogiri.parse(File.read(file_path))
    
    lib_node = doc.xpath("/plist/dict")[0]
    lib_metadata = {}
    lib_node.xpath("key").each do |key_node|
      key_sym = key_node.content.downcase.gsub(/ +/,'_').to_sym
      lib_metadata[key_sym] = key_node.next.content
    end
    self.persistent_id = lib_metadata[:library_persistent_id]
    
    track_nodes = doc.xpath("/plist/dict/dict/dict")
    track_nodes.each do |track_node|
      song_metadata = {}
      track_node.xpath("key").each do |key_node|
        key_sym = key_node.content.downcase.gsub(/ +/,'_').to_sym
        song_metadata[key_sym] = key_node.next.content
      end
      track_persistent_id = song_metadata[:persistent_id]
      track = Track.find_by_persistent_id(track_persistent_id)
      if track.nil?
        track = Track.new
        track.parse(song_metadata)
      end
      self.tracks << track
    end
  end

  
end
