class ArtistsController < ApplicationController
  before_filter :authorize
  
  def show
    @artist = LfmArtist.find(params[:id])
  end
  
  def album
  end
  
  def track
  end
  
end
