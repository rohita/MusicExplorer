require 'nokogiri'
require 'open-uri'

class LfmAlbum
  
  attr_accessor :title
  attr_accessor :artist_name
  attr_accessor :release_date
  attr_accessor :description
  attr_accessor :image_url
  
  def self.find(album_name, artist_name)
    album_name_encoded = URI.escape(album_name, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    artist_name_encoded = URI.escape(artist_name, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    
    lfm_url = "#{LASTFM_URL}?method=album.getinfo&api_key=#{LASTFM_KEY}"
    album_url = "#{lfm_url}&artist=#{artist_name_encoded}&album=#{album_name_encoded}"
    doc = Nokogiri::XML(open(album_url)) 
    
    album = LfmAlbum.new
    album.title = doc.xpath("lfm/album/name").first.content
    album.artist_name = doc.xpath("lfm/album/artist").first.content
    album.image_url = doc.xpath("lfm/album/image[@size='extralarge']").first.content
    release_date = doc.xpath("lfm/album/releasedate").first.content
    album.release_date = "Unknown"
    album.release_date = release_date.split(",").first if !release_date.blank?
    album.description = "No description available."
    summary = doc.xpath("lfm/album/wiki/summary").first
    album.description = summary.content unless summary.nil? 
  
    return album
  end
end
