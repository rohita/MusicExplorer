class ArtistsController < ApplicationController
  before_filter :authorize
  
  def show
    @artist = LfmArtist.find(params[:id])
  end
  
  def album
    @album = LfmAlbum.find(params[:album_id], params[:artist_id])
  end
  
  def track
    @track = LfmTrack.find(params[:track_id], params[:artist_id])
  end
  
end
