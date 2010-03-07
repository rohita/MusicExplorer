require 'nokogiri'
require 'open-uri'

class LfmTrack
  
  attr_accessor :name
  attr_accessor :duration
  attr_accessor :artist_name
  attr_accessor :album_name
  attr_accessor :image_url
  attr_accessor :description
  attr_accessor :similar_tracks
  attr_accessor :similar_url
  
  def self.find(track_name, artist_name)
    track_name_encoded = URI.escape(track_name, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    artist_name_encoded = URI.escape(artist_name, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    
    lfm_url = "#{LASTFM_URL}?method=track.getinfo&api_key=#{LASTFM_KEY}"
    track_url = "#{lfm_url}&artist=#{artist_name_encoded}&track=#{track_name_encoded}"
    doc = Nokogiri::XML(open(track_url)) 
       
    track = LfmTrack.new
    track.name = doc.xpath("lfm/track/name").first.content
    track.duration = doc.xpath("lfm/track/duration").first.content
    track.artist_name = doc.xpath("lfm/track/artist/name").first.content
    track.description = "No description available."
    summary = doc.xpath("lfm/track/wiki/summary").first
    track.description = summary.content unless summary.nil? 
    track.album_name = doc.xpath("lfm/track/album/title").first.content
    track.image_url = doc.xpath("lfm/track/album/image[@size='extralarge']").first.content

    lfm_url = "#{LASTFM_URL}?method=track.getsimilar&api_key=#{LASTFM_KEY}"
    simtracks_url = "#{lfm_url}&artist=#{artist_name_encoded}&track=#{track_name_encoded}"
    doc = Nokogiri::XML(open(simtracks_url))
    
    i = 0
    track.similar_tracks = []
    doc.xpath('/lfm/similartracks/track').each do |track_node|
      simtrack = LfmTrack.new
      simtrack.name = track_node.xpath("name").inner_text
      simtrack.duration = track_node.xpath("duration").inner_text
      simtrack.artist_name = track_node.xpath("artist/name").inner_text
      simtrack.image_url = track_node.xpath("image[@size='small']").inner_text
      track.similar_tracks << simtrack
      i += 1
      break if i == 10
    end
    track.similar_url = simtracks_url
    return track
  end
  
  def is_favorite_of(user_id)
    favorite = Favorite.find(:first, 
      :conditions => ["user_id = ? and artist_id = ? and album_id = '_' and track_id = ?", 
        user_id, artist_name, name])
    
    return true unless favorite.nil?
    return false
  end
  
end
