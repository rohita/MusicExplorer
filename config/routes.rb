ActionController::Routing::Routes.draw do |map|
  map.root :controller => :sessions, :action => :new
  map.resources :users
  map.resources :artists
  map.resource :sessions
end
