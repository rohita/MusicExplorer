require 'nokogiri'
require 'open-uri'

class LfmArtist
  
  attr_accessor :name
  attr_accessor :image_url
  attr_accessor :bio
  attr_accessor :similar_artists
  attr_accessor :top_tracks
  
  def self.find(input_name)
    name_url_encoded = URI.escape(input_name, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    artist_url = "#{LASTFM_URL}artist/#{name_url_encoded}/info.xml"
    doc = Nokogiri::XML(open(artist_url)) 
       
    artist = LfmArtist.new
    artist.name = doc.xpath("artist/name").first.content
    artist.image_url = doc.xpath("artist/image[@size='extralarge']").first.content
    artist.bio = doc.xpath("artist/bio/summary").first.content
    
    artist.similar_artists = []
    doc.xpath("artist/similar/artist").each do |node|
      sim = LfmArtist.new
      sim.name = node.xpath("name").first.content
      sim.image_url = node.xpath("image[@size='medium']").first.content
      sim.image_url["/64/"] = "/64s/"
      artist.similar_artists << sim
    end
    
    lfm_url = "#{LASTFM_URL}?method=artist.gettoptracks&api_key=#{LASTFM_KEY}"
    toptracks_url = "#{lfm_url}&artist=#{name_url_encoded}"
    doc = Nokogiri::XML(open(toptracks_url))
    
    i = 0
    artist.top_tracks = []
    doc.xpath('/lfm/toptracks/track').each do |track_node|
      artist.top_tracks << track_node.xpath("name").inner_text
      i += 1
      break if i == 10
    end
    
    return artist
  end
  
end
