ActionController::Routing::Routes.draw do |map|
  map.root :controller => :sessions, :action => :new
  map.resource :sessions
  map.resources :users
  map.resources :artists do |artist|
      artist.album ':album_id', :controller => :artists, :action => 'album'
      artist.track ':album_id/:track_id', :controller => :artists, :action => 'track'
  end
end
