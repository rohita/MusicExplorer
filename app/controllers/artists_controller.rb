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
  
  def update
    if !params[:id].nil? 
      favorite = Favorite.find(:first, 
        :conditions => ["user_id = ? and artist_id = ? and album_id = '_' and track_id = '_'", current_user.id, params[:id]])
      
      if favorite.nil? 
        favorite = Favorite.new
        favorite.user = current_user
        favorite.artist_id = params[:id]
        favorite.album_id = "_"
        favorite.track_id = "_"
        favorite.save!
      else 
        favorite.destroy
      end
      
      @artist = LfmArtist.find(params[:id])
      render :show
    elsif params[:track_id].nil?
      favorite = Favorite.find(:first, 
        :conditions => ["user_id = ? and artist_id = ? and album_id = ? and track_id = '_'", 
          current_user.id, params[:artist_id], params[:album_id]])
      
      if favorite.nil? 
        favorite = Favorite.new
        favorite.user = current_user
        favorite.artist_id = params[:artist_id]
        favorite.album_id = params[:album_id]
        favorite.track_id = "_"
        favorite.save!
      else 
        favorite.destroy
      end
      
      @album = LfmAlbum.find(params[:album_id], params[:artist_id])
      render :album
    else
      favorite = Favorite.find(:first, 
        :conditions => ["user_id = ? and artist_id = ? and album_id = '_' and track_id = ?", 
          current_user.id, params[:artist_id], params[:track_id]])
      
      if favorite.nil? 
        favorite = Favorite.new
        favorite.user = current_user
        favorite.artist_id = params[:artist_id]
        favorite.album_id = "_"
        favorite.track_id = params[:track_id]
        favorite.save!
      else 
        favorite.destroy
      end
      @track = LfmTrack.find(params[:track_id], params[:artist_id])
      render :track
    end    
  end
  
  
end
