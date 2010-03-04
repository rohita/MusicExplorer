class ArtistsController < ApplicationController
  before_filter :authorize
  
  def show
    @artist = Artist.find(params[:id])
  end
end
