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

    return track
  end
  
end
