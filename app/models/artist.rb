require 'nokogiri'
require 'open-uri'
LASTFM_URL = "http://ws.audioscrobbler.com/2.0/"

class Artist
  
  attr_accessor :name
  attr_accessor :image_url
  attr_accessor :bio
  attr_accessor :similar_artists
  attr_accessor :events
  
  def self.find(input_name)
    name_url_encoded = URI.escape(input_name, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    artist_url = "#{LASTFM_URL}artist/#{name_url_encoded}/info.xml"
    doc = Nokogiri::XML(open(artist_url)) 
       
    artist = Artist.new
    artist.name = doc.xpath("artist/name").first.content
    artist.image_url = doc.xpath("artist/image[@size='extralarge']").first.content
    artist.bio = doc.xpath("artist/bio/summary").first.content
    
    artist.similar_artists = []
    doc.xpath("artist/similar/artist").each do |node|
      sim = Artist.new
      sim.name = node.xpath("name").first.content
      sim.image_url = node.xpath("image[@size='medium']").first.content
      sim.image_url["/64/"] = "/64s/"
      artist.similar_artists << sim
    end
    
    return artist
  end
  
end
